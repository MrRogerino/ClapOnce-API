class IncidentsController < ApplicationController
  def create
    @incident = Incident.new(incident_params)
    if @incident.save
      render json: {incident: @incident}.as_json, status: 201
    else
      render json: {errors: @incident.errors.full_messages}, status: 500
    end
  end

  private

  def incident_params
    params.require(:data).permit(:type, :latitude, :longitude, :severity)
  end

end
