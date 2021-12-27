class LcdService

  @@dlist = []

  def self.display(pi_name, temperature_reading)
    self.add_to_list(pi_name, temperature_reading)
    puts @@dlist
    argv = "\"#{@@dlist[0][:pi_short_name]} #{@@dlist[0][:temperature]}  #{@@dlist[1][:pi_short_name] if @@dlist[1]} #{@@dlist[1][:temperature] if @@dlist[1]}\" \"#{@@dlist[2][:pi_short_name] if @@dlist[2]} #{@@dlist[2][:temperature] if @@dlist[2]}  #{@@dlist[3][:pi_short_name] if @@dlist[3]} #{@@dlist[3][:temperature] if @@dlist[3]}\""
    puts "argv: #{argv}"
    `python3 lib/lcd_scripts/display_two_messages.py #{argv}`
  end

  def self.add_to_list(pi_name, temperature_reading)
    if index = @@dlist.index { |previous_record| previous_record[:pi_name] == pi_name }
      @@dlist[index][:temperature] = temperature_reading
    else
      @@dlist.push({
        pi_name: pi_name,
        pi_short_name: pi_name[0..3].capitalize,
        temperature: temperature_reading.to_i
      })
    end
  end

end