class Wish
  require "date"

  attr_accessor :created_at, :descr, :due_date,

  def initialize
    @created_at = nil
    @descr = []
    @due_date = nil
  end
    
  def read_from_console
    @created_at = Time.now

    puts "В этом сундуке хранятся ваши желания.
    Чего бы вы хотели?"

    @descr = STDIN.gets.chomp

    puts "До какого числа вы хотите осуществить это желание?
    (укажите дату в формате ДД.ММ.ГГГГ)"

    input = STDIN.gets.chomp

    if input == ""
      @due_date = Date.today
    else
      @due_date = Date.parse(input)
    end
  end


  def info
    deadline = "Крайний срок: #{@due_date.strftime('%d.%m.%Y')}"
    time_string = "Создано: #{@created_at.strftime('%d.%m.%Y, %H:%M:%S')}"
    description = "#{@descr}"

    info = [deadline, description, time_string]
  end
end

