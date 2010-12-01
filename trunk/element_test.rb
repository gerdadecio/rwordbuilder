require "base_test_case.rb"
require 'stringio'
require "element.rb"

class ElementTest < BaseTestCase
  
  def test_empty
    element = Element.new("a", "foo")
    compare("empty", element, '<a:foo />')
  end
  
  def test_only_attributes
    element = Element.new("a", "foo")
    element.add_new_attribute("b", "flavor", "fudge")
    compare("only attributes", element, '<a:foo b:flavor="fudge" />')
  end
  
  def test_only_contents
    element = Element.new("a", "foo")
    element.add_content("hi there")
    compare("only contents", element, '<a:foo>hi there</a:foo>')
  end
  
  def test_only_child_slow_way
    element = Element.new("a", "foo")
    child = Element.new("a", "bar")
    element.add_element(child)
    compare("slow way", element, '<a:foo><a:bar /></a:foo>')
  end
  
  def test_only_child_fast_way
    element = Element.new("a", "foo")
    element.add_new_element("a", "bar")
    compare("fast way", element, '<a:foo><a:bar /></a:foo>')
  end
  
  def test_attributes_and_children_fast_way
    element = Element.new("a", "foo")
    element.add_new_attribute("b", "flavor", "fudge")
    element.add_new_element("a", "bar").add_new_attribute("b", "type", "iron")
    compare("attributes and children slow", element, '<a:foo b:flavor="fudge"><a:bar b:type="iron" /></a:foo>')
  end
  
  def test_attributes_and_children_and_content_fast_way
    element = Element.new("a", "foo")
    element.add_new_attribute("b", "flavor", "fudge")
    bar = element.add_new_element("a", "bar")
    bar.add_new_attribute("b", "type", "iron")
    bar.add_content("hi there")
    compare("attributes and children and content fast", element, '<a:foo b:flavor="fudge"><a:bar b:type="iron">hi there</a:bar></a:foo>')
  end  
  
  def test_attributes_and_children_slow_way
    element = Element.new("a", "foo")
    element.add_new_attribute("b", "flavor", "fudge")
    child = Element.new("a", "bar")
    child.add_new_attribute("b", "type", "iron")
    element.add_element(child)
    compare("attributes and children slow", element, '<a:foo b:flavor="fudge"><a:bar b:type="iron" /></a:foo>')
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
    
    expected = <<HERE
<a:foo b:flavor="fudge">
  <a:bar b:type="iron" />
  <c:bar b:type="iron" />
</a:foo>
HERE
    
    compare("deep", element, expected)
  end

end