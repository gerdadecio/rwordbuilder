require "element.rb"
require "property_injector.rb"

# The Paragraph class represents a WordML paragraph element.
# It is worth noting that Paragraph contains elements, but is not a subtype of Element.
#
# see ParagraphTest
class Paragraph
  @@p_pr = Element.new("w", "pPr")
  @@center_injectable = Element.new("w", "jc")
  @@center_injectable.add_new_attribute("w", "val", "center")
  
  CENTER = PropertyInjector.new(@@p_pr, @@center_injectable, true)
  
  def initialize(text, *property_injectors)
    @p_element = Element.new("w", "p")
    @p_element.add_new_element("w", "pPr")
    @run_element = @p_element.add_new_element("w", "r")
    @run_element.add_new_element("w", "rPr")
    @run_element.add_new_element("w", "t").add_content(text)
    
    property_injectors.each do |injector|
      injector.inject(@p_element)
    end
  end
  
  def build_to(buffer)  
    @p_element.build_to(buffer)
  end
  
end