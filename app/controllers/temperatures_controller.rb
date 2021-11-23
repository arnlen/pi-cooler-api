class TemperaturesController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET /temperatures or /temperatures.json
  def index
    @temperatures = Temperature.all
  end

  # GET /temperatures/1 or /temperatures/1.json
  def show
  end

  # GET /temperatures/new
  def new
    @temperature = Temperature.new
  end

  # POST /temperatures or /temperatures.json
  def create
    @temperature = Temperature.new(temperature_params)
    Temperature.add(pi_name: @temperature.pi_name, reading: @temperature.reading)

    if TemperatureService.max_temperature_reach?
      FanService.start_fans
    else
      FanService.stop_fans
    end

    puts Temperature.all

    respond_to do |format|
      format.html { redirect_to temperatures_path, notice: "Temperature was successfully created." }
      format.json { head :created }
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def temperature_params
      params.require(:temperature).permit(:pi_name, :reading)
    end
end
