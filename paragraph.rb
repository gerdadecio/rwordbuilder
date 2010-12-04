require "element.rb"
require "property_injector.rb"

# The Paragraph class represents a WordML paragraph element.
# It is worth noting that Paragraph contains elements, but is not a subtype of Element.
#
# see ParagraphTest
class Paragraph
  @@p_pr = Element.new("w", "pPr")  # paragraph properties
  @@r_pr = Element.new("w", "rPr")  # run properties
  
  LEFT = PropertyInjector.new(@@p_pr, Element.new_with_attribute("w", "jc", "w", "val", "left"), true)
  CENTER = PropertyInjector.new(@@p_pr, Element.new_with_attribute("w", "jc", "w", "val", "center"), true)
  RIGHT = PropertyInjector.new(@@p_pr, Element.new_with_attribute("w", "jc", "w", "val", "right"), true)
  
  BOLD = PropertyInjector.new(@@r_pr, Element.new_with_attribute("w", "b", "w", "val", "on"), true)
  ITALIC = PropertyInjector.new(@@r_pr, Element.new_with_attribute("w", "i", "w", "val", "on"), true)
  UNDERLINE = PropertyInjector.new(@@r_pr, Element.new_with_attribute("w", "u", "w", "val", "single"), true)
  
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