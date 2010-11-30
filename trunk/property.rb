class Property
  def initialize(namespace, name, attribute, global)
    @namespace = namespace
    @name = name
    @attribute = attribute
    @global = global
    @consumed = false
  end
  
  def inject(element)
    if match?(element) && !@consumed
      element.add_attribute(@attribute)
      @consumed = true unless @global      
    end
    
    if !@consumed
      element.each_child do |child|
        inject(child)
      end
    end
  end
  
  
  private
  def match?(element)
    element.namespace == @namespace && element.name == @name 
  end
  
end