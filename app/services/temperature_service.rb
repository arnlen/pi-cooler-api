class TemperatureService

  def self.max_temperature_reach?
    Temperature.last_readings.each do |last_reading|
      return true if last_reading >= $max_temperature
    end
    false
  end

  private

  attr_reader :max_temperature

  # TODO: extract this to config file
  $max_temperature = 70
end