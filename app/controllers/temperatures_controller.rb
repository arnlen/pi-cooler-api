class TemperaturesController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET /temperatures or /temperatures.json
  def index
    @temperatures = Temperature.all
  end

  # POST /temperatures or /temperatures.json
  # Params: {"temperature"=>{"pi_name"=>"alphapi", "reading"=>49.1}}
  def create
    @temperature = Temperature.new(
      pi_name: temperature_params["pi_name"],
      reading: temperature_params["reading"]
    )

    @temperature.save

    if LcdService.should_update_display? && !LcdService.refresh_already_in_progress?
      LcdService.refresh_readings
    end

    respond_to do |format|
      format.json { head :created }
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def temperature_params
      params.require(:temperature).permit(:pi_name, :reading)
    end
end
