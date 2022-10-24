class WishWriter

  def create
    Wish.new
  end

  def read_from_xml(file_name)
    begin
      file = File.new(file_name, "r:UTF-8")
      doc = REXML::Document.new(file)
      rescue REXML::ParseException => e
        abort e.message
      end
      file.close
      doc
  end

  def add_wish(wish_list, info)
    wish = wish_list.root.add_element("wish")

    wish.add_element("time_string").text = info[2]
    wish.add_element("description").text = info[1]
    wish.add_element("deadline").text = info[0]

    wish_list
  end

  def save(wish_list_upd, file_name)
    file = File.new(file_name, "w:UTF-8")
    wish_list_upd.write(file, 4)
    file.close
  end
end