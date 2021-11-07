class Temperature < ApplicationRecord

  $temperatures = {
    cooler: [],
    router: [],
    compute_1: [],
    compute_2: [],
    compute_3: [],
    compute_4: [],
  }

  def self.all
    $temperatures
  end

  def self.add(pi_name:, reading:)
    $temperatures[pi_name.to_sym].push(reading)
  end

end
