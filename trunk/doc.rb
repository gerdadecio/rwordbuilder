require 'stringio'
require 'element.rb'

class Doc
  
  PRINT_VIEW = 'print'
  ARIAL = 'arial'
  
  def initialize
    build_root
  end
  
  def view=(view_type)
    @doc_properties.add_new_element("w", "view").add_new_attribute("w", "val", view_type)
  end
  
  def add_paragraph(content)
    paragraph = @body.add_new_element("w", "p")
    run = paragraph.add_new_element("w", "r")
    text = run.add_new_element("w", "t")
    text.add_content(content)
  end
  
  def build_to(buffer)
    buffer << xml_headers  
    @root.build_to(buffer)
  end
  
  private
  
  def xml_headers
    return  <<HERE
<?xml version="1.0" encoding="UTF-8"?>
HERE
  end
  
  def build_root
    @root = Element.new("w", "wordDocument")
    
    @root.add_new_attribute("xmlns", "aml", "http://schemas.microsoft.com/aml/2001/core")
    @root.add_new_attribute("xmlns", "o", "urn:schemas-microsoft-com:office:office")
    @root.add_new_attribute("xmlns", "sl", "http://schemas.microsoft.com/schemaLibrary/2003/core") 
    @root.add_new_attribute("xmlns", "vml", "urn:schemas-microsoft-com:vml") 
    @root.add_new_attribute("xmlns", "w", "http://schemas.microsoft.com/office/word/2003/wordml")
    @root.add_new_attribute("xmlns", "wsp", "http://schemas.microsoft.com/office/word/2003/wordml/sp2") 
    @root.add_new_attribute("xmlns", "wx", "http://schemas.microsoft.com/office/word/2003/auxHint") 
    @root.add_new_attribute("xmlns", "wxml", "http://www.w3.org/XML/1998/namespace") 
    @root.add_new_attribute("xmlns", "xsi", "http://www.w3.org/2001/XMLSchema-instance") 
    @root.add_new_attribute("xsi", "schemaLocation", "http://schemas.microsoft.com/office/word/2003/wordml wordnet.xsd")
    
    
    @doc_properties = @root.add_new_element("w", "docPr")
    
    @body = @root.add_new_element("w", "body")
  end  
  
end
