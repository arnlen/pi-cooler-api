class Temperature < ApplicationRecord

  @@temperatures = {}

  def self.all
    @@temperatures
  end

  def self.add(pi_name:, reading:)
    @@temperatures[pi_name.to_sym] = [] unless @@temperatures[pi_name.to_sym]
    @@temperatures[pi_name.to_sym].push(reading)

    @@temperatures[pi_name.to_sym].shift if @@temperatures[pi_name.to_sym].size > 20
  end

  def self.last_readings
    @@temperatures.values.collect do |temperature|
      temperature.last
    end.compact
  end

end
