class TemperatureService

  $max_temperature = 70

  def self.max_temperature
    $max_temperature
  end

  def self.max_temperature_reach?
    Temperature.last_readings.each do |last_reading|
      return true if last_reading.to_i >= $max_temperature.to_i
    end
    false
  end
end