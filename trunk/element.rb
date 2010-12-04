require "attribute.rb"

# The Element class represents a XML element that can contain other elements as well as being decorated with
# a namespace and attributes.
# 
# see #ElementTest
class Element
  attr_reader :namespace, :name
  
  def initialize(namespace, name)
    @namespace = namespace
    @name = name
    @attributes = []
    @child_elements = []
    @contents = []
  end
  
  def add_content(content)
    @contents << content  
  end
  
  def add_new_attribute(namespace, name, value)
    @attributes << Attribute.new(namespace, name, value)
  end
  
  def add_attribute(attribute)
    @attributes << attribute
  end
  
  def add_new_element(namespace, name)
    element = Element.new(namespace, name)
    @child_elements << element
    return element
  end
  
  def add_element(element)
    @child_elements << element
  end
  
  def build_to(buffer)
    buffer << "<#{@namespace}:#{@name}"
    
    @attributes.each do |attribute|
      buffer << " "
      attribute.build_to(buffer)      
    end
    
    if @child_elements.length == 0 && @contents.length == 0
      buffer << " />"
    else
      buffer << ">"
      
      @contents.each do |content|
        buffer << content
      end
      
      @child_elements.each do |child|
        child.build_to(buffer)
      end
      
      buffer << "</#{@namespace}:#{@name}>"
    end    
  end
  
  def each_child
    @child_elements.each do |child|
      yield child
    end
  end
  
  def self.new_with_attribute(namespace, name, attribute_namespace, attribute_name, attribute_value)
    new_element = Element.new(namespace, name)
    new_element.add_new_attribute(attribute_namespace, attribute_name, attribute_value)
    return new_element
  end
  
  
end