require 'stringio'
require 'element.rb'
require "property_injector.rb"

# The Doc class represents a WordML document
class Doc

  #TODO current section, current paragraph...
  #TODO unit test
  
  @@doc_pr = Element.new("w", "docPr")  # document properties
  
  VIEW_PRINT = PropertyInjector.new(@@doc_pr, Element.new_with_attribute("w", "view", "w", "val", "print"), false)
  VIEW_WEB = PropertyInjector.new(@@doc_pr, Element.new_with_attribute("w", "view", "w", "val", "web"), false)
  VIEW_NORMAL = PropertyInjector.new(@@doc_pr, Element.new_with_attribute("w", "view", "w", "val", "normal"), false)
  VIEW_OUTLINE = PropertyInjector.new(@@doc_pr, Element.new_with_attribute("w", "view", "w", "val", "outline"), false)
  
  def initialize(*property_injectors)
    build_root
    
    property_injectors.each do |injector|
      injector.inject(@root)
    end
  end
  
  def add_new_paragraph(content, *properties)
    if properties.empty?
      paragraph = Paragraph.new(content)
    else
      paragraph = Paragraph.new(content, properties[0])
    end
    
    @body.add_element(paragraph.root_element)
  end
  
  def add_paragraph(paragraph)
    @body.add_element(paragraph.root_element)
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
