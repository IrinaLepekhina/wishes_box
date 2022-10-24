class WishWriter

  def create
    Wish.new
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

  def add_wish(wish_list, info)
    wish = wish_list.root.add_element("wish")

    wish.add_element("deadline").text = info[0]
    wish.add_element("description").text = info[1]
    wish.add_element("time_string").text = info[2]

    wish_list
  end

  def save(wish_list_upd, file_name)
    file = File.new(file_name, "w:UTF-8")
    wish_list_upd.write(file, 4)
    file.close
  end
end