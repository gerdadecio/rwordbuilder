require 'doc.rb'
require "paragraph.rb"
require "table.rb"

buffer = StringIO.new
doc = Doc.new(Doc::VIEW_PRINT)
doc.add_new_paragraph("Hello World")

# easy, but less control
doc.add_new_paragraph("hi left", Paragraph::LEFT)

#TODO do we need pass of paragraph? Or should add_new return what it added?
# explicit constructor and more control
my_paragraph = Paragraph.new("hi centered", Paragraph::CENTER)
my_paragraph.add_run(" with some bold and underlined text", Paragraph::BOLD, Paragraph::UNDERLINE)
doc.add_paragraph(my_paragraph)
doc.add_paragraph(Paragraph.new("hi right", Paragraph::RIGHT, Paragraph::BOLD, Paragraph::ITALIC, Paragraph::UNDERLINE))

table = Table.new(2)
table.add_data_row("Hi", "There")
table.add_data_row("A very pointless table", "")
doc.add_table(table)

doc.build_to(buffer)
puts "content=\n#{buffer.string}"
File.open("documents/silly.doc", "w") do |file|
  file.puts buffer.string
end

File.open("documents/silly.xml", "w") do |file|
  file.puts buffer.string
end
