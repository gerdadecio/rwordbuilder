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
  
  def test_centered_paragraph
    expected = <<HERE
<w:p>
  <w:pPr>
    <w:jc w:val="center" />
  </w:pPr>
  <w:r>
    <w:rPr />
    <w:t>Centered</w:t>
  </w:r>
</w:p>
HERE
    
    paragraph = Paragraph.new("Centered", Paragraph::CENTER)
    compare("centered paragraph", paragraph, expected)
  end
  
  def test_complicated_paragraph
    expected = <<HERE
<w:p>
 <w:pPr>
  <w:jc w:val="right" />
 </w:pPr>
  <w:r>
    <w:rPr>
      <w:b w:val="on" /><w:i w:val="on" /><w:u w:val="single" />
    </w:rPr>
    <w:t>Complicated</w:t>
  </w:r>
</w:p>
HERE
  
  paragraph = Paragraph.new("Complicated", Paragraph::RIGHT, Paragraph::BOLD, Paragraph::ITALIC, Paragraph::UNDERLINE)
  compare("complicated paragraph", paragraph, expected)
  
  end
  
  
  
end