require "element.rb"

class Paragraph
  
  def initialize(text)
    @p_element = Element.new("w", "p")
    @p_element.add_new_element("w", "pPr")
    @run_element = @p_element.add_new_element("w", "r")
    @run_element.add_new_element("w", "rPr")
    @run_element.add_new_element("w", "t").add_content(text)
  end
  
  def build_to(buffer)  
    @p_element.build_to(buffer)
  end
end