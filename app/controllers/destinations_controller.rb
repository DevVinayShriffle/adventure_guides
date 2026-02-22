class DestinationsController < ApplicationController
  before_action :set_destination, only: [:show]

  def index
    @destinations = Destination.all.order(created_at: :desc)

    respond_to do |format|
      format.html
      format.json do
        if @destinations.present?
          render json: { destinations: @destinations }, status: :ok
        else
          render json: { message: "No destinations found." }, status: :ok
        end
      end
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json do
        render json: { destination: @destination }, status: :ok
      end
    end
  end

  private

  def set_destination
    @destination = Destination.find(params[:id])
  end
end