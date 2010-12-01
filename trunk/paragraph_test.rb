require "base_test_case.rb"
require "paragraph.rb"

class ParagraphTest < BaseTestCase
  
  def test_simple_paragraph
    expected = <<HERE
<w:p>
  <w:pPr />
  <w:r>
    <w:rPr />
    <w:t>Hi There</w:t>
  </w:r>
</w:p>
HERE
    
    paragraph = Paragraph.new("Hi There")
    compare("simple paragraph", paragraph, expected)
  end
  
  
  
end