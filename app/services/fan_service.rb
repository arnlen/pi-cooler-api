class FanService

  def initialize
  end

  def start_fans
    `python lib/fan_scripts/start_fans.py`
  end

  def stop_fans
    `python lib/fan_scripts/stop_fans.py`
  end

end