# frozen_string_literal: true

class WishWriter
  def read_from_console(wish_list)
    created_at = Time.now

    puts "В этом сундуке хранятся ваши желания.
    Чего бы вы хотели?"
    descr = $stdin.gets.chomp

    puts "До какого числа вы хотите осуществить это желание?
    (укажите дату в формате ДД.ММ.ГГГГ)"
    input = $stdin.gets.chomp

    due_date = if input == ''
                 Date.today
               else
                 Date.parse(input)
               end

    init = [descr, created_at, due_date]
    Wish.new(init)
    add_wish(wish_list, init)
  end

  def add_wish(wish_list, init)
    wish = wish_list.root.add_element('wish')

    wish.add_element('description').add_text(init[0])
    wish.add_element('time_string').add_text(init[1].strftime('%d-%m-%Y'))
    wish.add_element('deadline').add_text(init[2].strftime('%a, %d %b %Y'))

    wish_list
  end

  def save(wish_list_upd, file_name)
    file = File.new(file_name, 'w:UTF-8')
    wish_list_upd.write(file, 2)
    file.close
  end

  def read_from_xml(file_name)
    file = File.new(file_name, 'r:UTF-8')
    doc = REXML::Document.new(file)
    file.close

    doc
  rescue REXML::ParseException => e
    abort e.message
  rescue Errno::ENOENT => e
    e.message
    file = File.open(file_name, 'w:UTF-8') do |file|
      # Добавим в документ служебную строку с версией и кодировкой и пустой тег
      file.puts "<?xml version='1.0' encoding='UTF-8'?>"
      file.puts '<wishes></wishes>'
      file.close

      file = File.new(file_name, 'r:UTF-8')
      doc = REXML::Document.new(file)
      file.close

      doc
    end
  end

  def init_table(node)
    descr = node.elements['description'].text
    created_at = Date.today
    due_date = Date.parse(node.elements['deadline'].text)

    init = [descr, created_at, due_date]
    Wish.new(init)
  end
end
