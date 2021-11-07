class FanService

  def self.start_fans
    `python lib/fan_scripts/start_fans.py`
  end

  def self.stop_fans
    `python lib/fan_scripts/stop_fans.py`
  end

end