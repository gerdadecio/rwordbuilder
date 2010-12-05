require "base_test_case.rb"
require "property_injector.rb"
require "element.rb"

class PropertyInjectorTest < BaseTestCase
  
  def setup
    create_nodes
    @marker = Element.new("t", "marker")
  end
  
  def test_simple_match        
    property_injector = PropertyInjector.new(Element.new("a", "house"), @marker, false)    
    property_injector.inject(@house)    
    compare("simple match", @house, '<a:house><b:dog><c:rex /><c:max /><c:spot /></b:dog><b:cat><c:fluffy /><c:tiger /><c:socks /></b:cat><b:people><c:joe /><c:jane /></b:people><t:marker /></a:house>')    
  end
  
  def test_can_reuse_injector      
    property_injector = PropertyInjector.new(Element.new("a", "house"), @marker, false)    
    property_injector.inject(@house)
    property_injector.inject(@house)  #reuse it
    compare("can reuse", @house, '<a:house><b:dog><c:rex /><c:max /><c:spot /></b:dog><b:cat><c:fluffy /><c:tiger /><c:socks /></b:cat><b:people><c:joe /><c:jane /></b:people><t:marker /><t:marker /></a:house>')    
  end
  
  def test_deep_match_left
    property_injector = PropertyInjector.new(Element.new("c", "rex"), @marker, false)    
    property_injector.inject(@house)    
    compare("deep left", @house, '<a:house><b:dog><c:rex><t:marker /></c:rex><c:max /><c:spot /></b:dog><b:cat><c:fluffy /><c:tiger /><c:socks /></b:cat><b:people><c:joe /><c:jane /></b:people></a:house>')
  end
  
  def test_only_first
    property_injector = PropertyInjector.new(Element.new("a", "bar"), @marker, false)    
    property_injector.inject(@foo)
    compare("only first", @foo, '<a:foo><a:fee><a:bar><a:bar /><t:marker /></a:bar></a:fee></a:foo>')
  end
  
  def test_global
    property_injector = PropertyInjector.new(Element.new("a", "bar"), @marker, true)
    property_injector.inject(@foo)
    compare("global", @foo, '<a:foo><a:fee><a:bar><a:bar><t:marker /></a:bar><t:marker /></a:bar></a:fee></a:foo>')
  end
  
  private
  
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