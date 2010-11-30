require "test/unit"
require 'stringio'
require "attribute.rb"

class AttributeTest < Test::Unit::TestCase
  def test_simple
    attribute = Attribute.new("a", "flavor", "fudge")
    buffer = StringIO.new
    attribute.build_to(buffer)
    assert_equal('a:flavor="fudge"', buffer.string)
  end
end