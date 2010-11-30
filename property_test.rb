require "test/unit"
require 'stringio'
require "property.rb"
require "element.rb"

class PropertyTest < Test::Unit::TestCase
  
  #TODO: add regular expressions
  #TODO: breadth first?
  
  def setup
    create_nodes
    @attribute = Attribute.new("t", "rank", "first")
  end
  
  def test_simple_match        
    property = Property.new("a", "house", @attribute, false)    
    property.inject(@house)    
    compare("simple match", @house, '<a:house t:rank="first"><b:dog><c:rex /><c:max /><c:spot /></b:dog><b:cat><c:fluffy /><c:tiger /><c:socks /></b:cat><b:people><c:joe /><c:jane /></b:people></a:house>')    
  end
  
  def test_deep_match_left
    property = Property.new("c", "rex", @attribute, false)    
    property.inject(@house)    
    compare("deep left", @house, '<a:house><b:dog><c:rex t:rank="first" /><c:max /><c:spot /></b:dog><b:cat><c:fluffy /><c:tiger /><c:socks /></b:cat><b:people><c:joe /><c:jane /></b:people></a:house>')
  end
  
  def test_only_first
    property = Property.new("a", "bar", @attribute, false)    
    property.inject(@foo)
    compare("only first", @foo, '<a:foo><a:fee><a:bar t:rank="first"><a:bar /></a:bar></a:fee></a:foo>')
  end
  
  def test_global
    property = Property.new("a", "bar", @attribute, true)    
    property.inject(@foo)
    compare("global", @foo, '<a:foo><a:fee><a:bar t:rank="first"><a:bar t:rank="first" /></a:bar></a:fee></a:foo>')
  end
  
  private
  
  def compare(name, root_element, expected)
    buffer = StringIO.new
    root_element.build_to(buffer)
    puts "#{name}: |#{buffer.string}|"
    assert_equal(expected, buffer.string)
  end
  
  def create_nodes
    @house = Element.new("a", "house")
    
    @b_dog = @house.add_new_element("b", "dog")
    @b_cat = @house.add_new_element("b", "cat")
    @b_people = @house.add_new_element("b", "people")
    
    @c_rex = @b_dog.add_new_element("c", "rex")
    @c_max = @b_dog.add_new_element("c", "max")
    @c_spot = @b_dog.add_new_element("c", "spot")
    
    @c_fluffy = @b_cat.add_new_element("c", "fluffy")
    @c_tiger = @b_cat.add_new_element("c", "tiger")
    @c_socks = @b_cat.add_new_element("c", "socks")
    
    @c_joe = @b_people.add_new_element("c", "joe")
    @c_jane = @b_people.add_new_element("c", "jane")  
    
    @foo = Element.new("a", "foo")
    fee = @foo.add_new_element("a", "fee")
    target = fee.add_new_element("a", "bar")
    target2 = target.add_new_element("a", "bar")
  end
end