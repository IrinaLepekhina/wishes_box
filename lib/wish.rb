class Wish

  def initialize(init)
    @descr = init[0]
    @created_at = init[1]
    @due_date = init[2]
  end
    
  def overdue?
    @due_date < Date.today
  end

  def info
    deadline = "Крайний срок: #{Date.parse(@due_date.strftime('%d.%m.%Y'))}"
    time_string = "Создано: #{Date.parse(@created_at.strftime('%d.%m.%Y'))}"
    description = "#{@descr}"

    info = [deadline, description, time_string]
  end
end

