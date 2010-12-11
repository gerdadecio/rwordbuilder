require "element.rb"
require "property_injector.rb"

# The Table class represents a WordML table element.
# It is worth noting that Table contains elements, but is not a subtype of Element.
#
# see TableTest
class Table
  def initialize(columns)
    @tbl_element = Element.new("w", "tbl")
    tbl_pr = @tbl_element.add_new_element("w", "tblPr")
    
    tbl_w = tbl_pr.add_new_element("w", "tblW")
    tbl_w.add_new_attribute("w", "w", "5000")    # 5000 is really 100 because the units are really tiny. Really, I can'y make this up...
    tbl_w.add_new_attribute("w", "type", "pct")  # percent of available width
    
    tbl_pr.add_element(Element.new_with_attribute("w", "tblLayout", "w", "type", "Fixed"))
    
    tbl_borders = tbl_pr.add_new_element("w", "tblBorders")
    tbl_borders.add_element(make_border("top"))
    tbl_borders.add_element(make_border("left"))
    tbl_borders.add_element(make_border("bottom"))
    tbl_borders.add_element(make_border("right"))
    tbl_borders.add_element(make_border("insideH"))
    tbl_borders.add_element(make_border("insideV"))
    
    tbl_grid = @tbl_element.add_new_element("w", "tblGrid")
    columns.times do |index|
        tbl_grid.add_new_element("w", "gridCol")
    end
  end
  
  def add_data_row(*data) 
    tr = @tbl_element.add_new_element("w", "tr")
    tr.add_new_element("w", "trPr")
        
    data.each do |datum|
      paragraph = Paragraph.new(datum)
      
      tc = tr.add_new_element("w", "tc")
      tc.add_new_element("w", "tcPr")
      tc.add_element(paragraph.root_element)      
    end
  end
  
  def root_element
    return @tbl_element
  end
  
   def build_to(buffer)  
    @tbl_element.build_to(buffer)
  end
  
  private
  
  def make_border(border)
    border_element = Element.new("w", border)
    border_element.add_new_attribute("w", "val", "single")
    border_element.add_new_attribute("w", "sz", "1")
    return border_element
    
  end
end