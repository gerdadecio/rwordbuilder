class Attribute
  def initialize(namespace, name, value)
    @namespace = namespace
    @name = name
    @value = value
  end
  
  def build_to(buffer)
    buffer << %Q(#{@namespace}:#{@name}="#{@value}")
    
    
  end
  
end