class PropertyInjector
  def initialize(target, injected_element, global)
    @target = target
    @injected_element = injected_element
    @global = global
    @consumed = false
  end
  
  def inject(element)
    @consumed = false
    if match?(element) && !@consumed
      element.add_element(@injected_element)
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