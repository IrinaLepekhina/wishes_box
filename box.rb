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

  # Запись нового желания #
wish_list = WishWriter.new.read_from_xml(file_name)
wish = WishWriter.new.read_from_console(wish_list)

WishWriter.new.save(wish_list, file_name)

puts "Запись сохранена"

  # Вывод прошедших и будущих по срокам #
wishes = []

wish_list.each_element("wishes/wish") do |wish_node|
  wishes << WishWriter.new.init_table(wish_node)
end

puts "-----------"
puts 'Эти желания должны были сбыться к сегодняшнему дню'
wishes.each { |wish| puts wish.info.to_s if wish.overdue? }

puts
puts 'А этим желаниям ещё предстоит сбыться'
wishes.each { |wish| puts wish.info.to_s unless wish.overdue? }
