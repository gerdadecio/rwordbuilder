class Property
  def initialize(target, property_element, global)
    @target = target
    @property_element = property_element
    @global = global
    @consumed = false
  end
  
  def inject(element)
    if match?(element) && !@consumed
      element.add_element(@property_element)
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
    element.namespace == @target.namespace && element.name == @target.name 
  end
  
end