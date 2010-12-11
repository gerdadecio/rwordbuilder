require "base_test_case.rb"
require "table.rb"

class TableTest < BaseTestCase
  def test_simple_table
    expected = <<HERE
<w:tbl>
      <w:tblPr>
        <w:tblW w:w="5000" w:type="pct" />
        <w:tblLayout w:type="Fixed" />
        <w:tblBorders>
          <w:top w:val="single" w:sz="1" />
          <w:left w:val="single" w:sz="1" />
          <w:bottom w:val="single" w:sz="1" />
          <w:right w:val="single" w:sz="1" />
          <w:insideH w:val="single" w:sz="1" />
          <w:insideV w:val="single" w:sz="1" />
        </w:tblBorders>
      </w:tblPr>

      <w:tblGrid>
        <w:gridCol />
        <w:gridCol />
      </w:tblGrid>

      <w:tr>
        <w:trPr />
        <w:tc>
          <w:tcPr />            
          <w:p>
            <w:pPr />
            <w:r>
              <w:rPr />
              <w:t>Hi there</w:t>
            </w:r>
          </w:p>
        </w:tc>

        <w:tc>
          <w:tcPr /> 
          <w:p>
            <w:pPr />
            <w:r>
              <w:rPr />
              <w:t>Another cell in the same row</w:t>
            </w:r>
          </w:p>
        </w:tc>
      </w:tr>
    </w:tbl>
HERE
    
    table = Table.new(2)
    table.add_data_row("Hi there", "Another cell in the same row")
    compare("simple table", table, expected)
  end
  
end