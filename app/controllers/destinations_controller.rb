class DestinationsController < ApplicationController
  before_action :set_destination, only: [:show]

  def index
    @destinations = Destination.all.order(created_at: :desc)
    
    # Scrapper.call('http://127.0.0.1:3000/destinations')
    respond_to do |format|
      format.html
      format.json do
        if @destinations.present?
          render json: @destinations, status: :ok
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
        render json: @destination, status: :ok
      end
    end
  end

  private

  def set_destination
    @destination = Destination.find_by(id: params[:id])
    render json: {message: "Destination not found."} unless @destination.present?
  end
end