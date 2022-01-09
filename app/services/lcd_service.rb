class LcdService

  @@display_last_updated_at = DateTime.now
  @@refresh_in_progress = false

  def self.should_update_display?
    puts "🕰 Display last updated at: #{@@display_last_updated_at}"
    should_update_display = @@display_last_updated_at < 2.minutes.ago
    "💤 No refresh required." unless should_update_display
    should_update_display
  end

  def self.refresh_already_in_progress?
    "🛑 Refresh already in progress. Waiting..." if @@refresh_in_progress
    @@refresh_in_progress
  end

  def self.refresh_readings
    # Lock to prevent concurrent access to LCD
    @@refresh_in_progress = true
    puts "🔄 Refreshing display..."

    readings = LcdService.get_readings
    puts "- Readings: #{readings}"

    positions = LcdService.format_readings_to_positions(readings)
    puts "- Positions: #{positions}"

    first_line = "#{positions[0]} #{positions[1]}"
    second_line = "#{positions[2]} #{positions[3]}"
    puts "- First line: #{first_line}"
    puts "- Second line: #{second_line}"

    argv = "\"#{first_line}\" \"#{second_line}\""
    puts "👉 Screen will be refresh to: #{argv}"

    LcdService.display_two_messages_to_screen(argv)

    @@display_last_updated_at = DateTime.now
    @@refresh_in_progress = false # Unlock screen access
    puts "✅ Screen refresh completed."
  end

  def self.display_two_messages_to_screen(argv)
    `python3 lib/lcd_scripts/display_two_messages.py #{argv}`
  end

  def self.get_readings
    Temperature.last_temperatures_per_pi.collect do |last_temperature|
      {
        pi_short_name: last_temperature.pi_short_name,
        reading: last_temperature.reading.round
      }
    end
  end

  def self.format_readings_to_positions(readings)
    readings.each_with_index.collect do |reading, index|
      "#{readings[index][:pi_short_name]} #{readings[index][:reading]}"
    end
  end

end