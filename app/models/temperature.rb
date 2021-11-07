class Temperature < ApplicationRecord

  def self.all
    $temperatures
  end

  def self.add(pi_name:, reading:)
    $temperatures[pi_name.to_sym].push(reading)
  end

  def self.last_readings
    $temperatures.values.collect do |temperature|
      temperature.last
    end.compact
  end

  private

  attr_reader :temperatures

  $temperatures = {
    cooler: [],
    router: [],
    compute_1: [],
    compute_2: [],
    compute_3: [],
    compute_4: [],
  }

end
