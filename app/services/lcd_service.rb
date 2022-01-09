class LcdService

  @@last_display_updated_at = DateTime.now

  def self.last_display_updated_at
    @@last_display_updated_at
  end

  def self.should_update_display?
    @@last_display_updated_at < 30.seconds.ago
  end

  def self.refresh_readings
    puts "Refreshing display..."

    readings = Temperature.last_temperatures_per_pi.collect do |last_temperature|
      {
        pi_short_name: last_temperature.pi_short_name,
        reading: last_temperature.reading
      }
    end

    puts "Readings: #{readings}"

    positions = readings.each_with_index.collect do |reading, index|
      "#{readings[index][:pi_short_name]} #{readings[index][:reading]}"
    end

    puts "Positions: #{positions}"

    first_line = "#{positions[0]} #{positions[1]}"
    second_line = "#{positions[2]} #{positions[3]}"

    puts "First line: #{first_line}"
    puts "Second line: #{second_line}"

    argv = "\"#{first_line}\" \"#{second_line}\""

    puts "Screen will be refresh to: #{argv}"

    `python3 lib/lcd_scripts/display_two_messages.py #{argv}`

    @@last_display_updated_at = DateTime.now
  end

end