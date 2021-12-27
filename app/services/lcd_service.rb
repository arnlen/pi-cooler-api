class LcdService

  @@dlist = []

  def self.display(pi_name, temperature_reading)
    self.add_to_list(pi_name, temperature_reading)
    puts @@dlist
    `python3 lib/lcd_scripts/display_two_messages.py "#{@@dlist[0][:pi_short_name]} #{@@dlist[0][:temperature]}    " "#{@@dlist[1][:pi_short_name] if @@dlist[1]} #{@@dlist[1][:temperature] if @@dlist[1]}"`
    `python3 lib/lcd_scripts/display_two_messages.py "#{@@dlist[2][:pi_short_name] if @@dlist[2]} #{@@dlist[2][:temperature] if @@dlist[2]}    " "#{@@dlist[3][:pi_short_name] if @@dlist[3]} #{@@dlist[3][:temperature] if @@dlist[3]}"`
  end

  def self.add_to_list(pi_name, temperature_reading)
    if index = @@dlist.index { |previous_record| previous_record[:pi_name] == pi_name }
      @@dlist[index][:temperature] = temperature_reading
    else
      @@dlist.push({
        pi_name: pi_name,
        pi_short_name: pi_name[0..2],
        temperature: temperature_reading
      })
    end
  end

end