class Temperature

  @@temperatures = []

  $reading_ttl = 3.minutes

  attr_accessor :pi_name,
                :pi_short_name,
                :reading,
                :created_at

  def initialize(pi_name:, reading:)
    @pi_name = pi_name
    @pi_short_name = pi_name[0..3].capitalize
    @reading = reading
    @created_at = DateTime.now
  end

  # --------------- INSTANCE METHODS --------------- #

  def save
    @@temperatures.push(self)
    Temperature.sanitize_database
  end

  # --------------- CLASS METHODS --------------- #

  def self.pi_names
    Temperature.all.collect do |temperature|
      temperature.pi_name
    end.uniq
  end

  def self.all
    @@temperatures
  end

  def self.sanitize_database
    @@temperatures.each_with_index do |record, index|
      if record.created_at < $reading_ttl.ago
        deleted = @@temperatures.delete_at(index)
        puts "🗑  Too old reading removed from database: #{deleted}"
      end
    end
  end

  def self.last_temperatures_per_pi
    Temperature.sanitize_database
    temperatures = Temperature.all.reverse
    pi_names = Temperature.pi_names

    pi_names.collect do |pi_name|
      temperatures.find { |record| record.pi_name == pi_name }
    end
  end

end
