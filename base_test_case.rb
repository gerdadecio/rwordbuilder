require 'test/unit'
require 'stringio'

class BaseTestCase < Test::Unit::TestCase
  
  def test_nada
    
  end
  
  def compare(name, root_element, expected)
    buffer = StringIO.new
    root_element.build_to(buffer)
    puts "#{name}: |#{buffer.string}|"
    assert_equal(flatten(expected), flatten(buffer.string))
  end
  
  def flatten(rawValue)
    flat = rawValue.gsub(/[\t\n]/, "")
    flat.gsub!(/>\W*</, "><")
    return flat
  end
  
end