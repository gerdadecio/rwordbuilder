require 'doc.rb'
require "paragraph.rb"

buffer = StringIO.new
doc = Doc.new(Doc::VIEW_PRINT)
doc.add_new_paragraph("Hello World")

doc.add_paragraph(Paragraph.new("hi left", Paragraph::LEFT))
doc.add_paragraph(Paragraph.new("hi centered", Paragraph::CENTER))
doc.add_paragraph(Paragraph.new("hi right", Paragraph::RIGHT, Paragraph::BOLD, Paragraph::ITALIC, Paragraph::UNDERLINE))

doc.build_to(buffer)
puts "content=\n#{buffer.string}"
File.open("documents/silly.doc", "w") do |file|
  file.puts buffer.string
end

File.open("documents/silly.xml", "w") do |file|
  file.puts buffer.string
end
