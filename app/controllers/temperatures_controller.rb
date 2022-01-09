class TemperaturesController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET /temperatures or /temperatures.json
  def index
    @temperatures = Temperature.all
  end

  # POST /temperatures or /temperatures.json
  def create
    @temperature = Temperature.new(pi_name: params[:pi_name], reading: params[:reading])

    LcdService.refresh_readings if LcdService.should_update_display?

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
