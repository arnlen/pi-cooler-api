class LCDService

  display_list = []

  def self.display(text_to_display)
    display_list.push(text_to_display)
    display_list = display_list.drop(1) if display_list.size > 2
    `python lib/lcd_scripts/display_two_messages.py #{display_list[0]} #{display_list[1]}`
  end

end