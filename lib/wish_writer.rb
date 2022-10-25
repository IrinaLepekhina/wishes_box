class WishWriter

  def read_from_console(wish_list)
    created_at = Time.now

    puts "В этом сундуке хранятся ваши желания.
    Чего бы вы хотели?"
    descr = STDIN.gets.chomp
    
    puts "До какого числа вы хотите осуществить это желание?
    (укажите дату в формате ДД.ММ.ГГГГ)"
    input = STDIN.gets.chomp

    if input == ""
      due_date = Date.today
    else
      due_date = Date.parse(input)
    end

    init = [descr, created_at, due_date]
    Wish.new(init)
    self.add_wish(wish_list, init)
  end

  def add_wish(wish_list, init)
    wish = wish_list.root.add_element("wish")

    wish.add_element("description").text = init[0]
    wish.add_element("time_string").text = init[1]
    wish.add_element("deadline").text = init[2]

    wish_list
  end

  def save(wish_list_upd, file_name)
    file = File.new(file_name, "w:UTF-8")
    wish_list_upd.write(file, 2)
    file.close
  end

  def read_from_xml(file_name)
    begin
      file = File.new(file_name, "r:UTF-8")
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

        file = File.new(file_name, "r:UTF-8")
        doc = REXML::Document.new(file)
        file.close
    
        doc
        end
    end
  end

  def init_table(node)
    descr = node.elements["description"].text
    created_at = Date.today
    due_date = Date.parse(node.elements["deadline"].text)

    init = [descr, created_at, due_date]
    Wish.new(init)
end


end