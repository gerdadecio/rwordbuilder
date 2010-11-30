require 'doc.rb'
require "element.rb"
require "attribute.rb"


buffer = StringIO.new
doc2 = Doc.new
doc2.view='print'
doc2.add_paragraph("Hello World")

doc2.build_to(buffer)
puts "content=\n#{buffer.string}"
File.open("documents/silly.doc", "w") do |file|
  file.puts buffer.string
end

File.open("documents/silly.xml", "w") do |file|
  file.puts buffer.string
end
