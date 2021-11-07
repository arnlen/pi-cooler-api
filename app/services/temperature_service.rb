class TemperatureService

  def self.max_temperature_reach?
    Temperature.last_readings.each do |last_reading|
      return true if last_reading >= $max_temperature
    end
    false
  end

  private

  attr_reader :max_temperature

  $max_temperature = 40
end