require 'doc.rb'
require "paragraph.rb"

buffer = StringIO.new
doc = Doc.new
doc.view='print'
doc.add_new_paragraph("Hello World")

paragraph = Paragraph.new("hi centered", Paragraph::CENTER)
doc.add_paragraph(paragraph)

doc.build_to(buffer)
puts "content=\n#{buffer.string}"
File.open("documents/silly.doc", "w") do |file|
  file.puts buffer.string
end

File.open("documents/silly.xml", "w") do |file|
  file.puts buffer.string
end
