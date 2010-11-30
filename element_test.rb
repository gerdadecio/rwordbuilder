require "test/unit"
require 'stringio'
require "element.rb"

class ElementTest < Test::Unit::TestCase
  
  def test_empty
    element = Element.new("a", "foo")
    buffer = StringIO.new
    element.build_to(buffer)
    puts "#{buffer.string}"
    assert_equal('<a:foo />', buffer.string)
  end
  
  def test_only_attributes
    element = Element.new("a", "foo")
    element.add_new_attribute("b", "flavor", "fudge")
    
    buffer = StringIO.new
    element.build_to(buffer)
    puts "#{buffer.string}"
    assert_equal('<a:foo b:flavor="fudge" />', buffer.string)
  end
  
  def test_only_contents
    element = Element.new("a", "foo")
    element.add_content("hi there")
    
    buffer = StringIO.new
    element.build_to(buffer)
    puts "#{buffer.string}"
    assert_equal('<a:foo>hi there</a:foo>', buffer.string)
  end
  
  def test_only_child_slow_way
    element = Element.new("a", "foo")
    child = Element.new("a", "bar")
    element.add_element(child)
    
    buffer = StringIO.new
    element.build_to(buffer)
    puts "#{buffer.string}"
    assert_equal('<a:foo><a:bar /></a:foo>', buffer.string)
  end
  
  def test_only_child_fast_way
    element = Element.new("a", "foo")
    element.add_new_element("a", "bar")
    
    buffer = StringIO.new
    element.build_to(buffer)
    puts "#{buffer.string}"
    assert_equal('<a:foo><a:bar /></a:foo>', buffer.string)
  end
  
  def test_attributes_and_children_fast_way
    element = Element.new("a", "foo")
    element.add_new_attribute("b", "flavor", "fudge")
    element.add_new_element("a", "bar").add_new_attribute("b", "type", "iron")
    
    buffer = StringIO.new
    element.build_to(buffer)
    puts "#{buffer.string}"
    assert_equal('<a:foo b:flavor="fudge"><a:bar b:type="iron" /></a:foo>', buffer.string)
  end
  
  def test_attributes_and_children_and_content_fast_way
    element = Element.new("a", "foo")
    element.add_new_attribute("b", "flavor", "fudge")
    bar = element.add_new_element("a", "bar")
    bar.add_new_attribute("b", "type", "iron")
    bar.add_content("hi there")
    
    buffer = StringIO.new
    element.build_to(buffer)
    puts "#{buffer.string}"
    assert_equal('<a:foo b:flavor="fudge"><a:bar b:type="iron">hi there</a:bar></a:foo>', buffer.string)
  end  
  
  def test_attributes_and_children_slow_way
    element = Element.new("a", "foo")
    element.add_new_attribute("b", "flavor", "fudge")
    child = Element.new("a", "bar")
    child.add_new_attribute("b", "type", "iron")
    element.add_element(child)
    
    buffer = StringIO.new
    element.build_to(buffer)
    puts "#{buffer.string}"
    assert_equal('<a:foo b:flavor="fudge"><a:bar b:type="iron" /></a:foo>', buffer.string)
  end
  
  def test_attributes_and_children_iteration
    element = Element.new("a", "foo")
    element.add_new_attribute("b", "flavor", "fudge")
    child = Element.new("a", "bar")
    child.add_new_attribute("b", "type", "iron")
    element.add_element(child)
    
    child2 = Element.new("c", "bar")
    child2.add_new_attribute("b", "type", "iron")
    element.add_element(child2)
    
    letters = ""
    element.each_child do |child|
      letters = letters + child.namespace+child.name
    end
    
    assert_equal("abarcbar", letters)
  end

end