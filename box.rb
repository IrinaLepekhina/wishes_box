if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

current_path = File.dirname(__FILE__)
require "rexml/document"
require "date"
require current_path + '/lib/wish.rb'
require current_path + '/lib/wish_writer.rb'

file_name = current_path + '/data/wishes.xml'


wish_list = WishWriter.new.read_from_xml(file_name)
wish = WishWriter.new.create
wish.read_from_console

info = wish.info

wish_list_upd = WishWriter.new.add_wish(wish_list, info)
WishWriter.new.save(wish_list_upd, file_name)

puts "Запись сохранена"