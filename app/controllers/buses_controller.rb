class BusesController < ApplicationController
  before_action :set_bus, only: [:show]

  def index
    if params[:destination_id].present?
      @destination = Destination.find_by(id: params[:destination_id])

      if @destination.present?
        @buses = Bus.joins(:schedules)
        .where(schedules: { destination_id: @destination.id }).distinct

      else
        @buses = []
      end
    else
      @buses = Bus.all.order(created_at: :desc)
    end

    respond_to do |format|
      format.html
      format.json do
        render json: @buses
      end
    end
  end

  def show
    @bus = Bus.includes(:bus_stops, schedules: :destination).find_by(id: params[:id])

    unless @bus
      redirect_to buses_path, alert: "Bus not found"
    end
    
    respond_to do |format|
      format.html
      format.json do
        if @bus.present?
          render json: @bus, status: :ok
        else
          render json: { message: "No bus found." }, status: :ok
        end
      end
    end
  end

  private

  def set_bus
    @bus = Bus.find_by(id: params[:id])
  end
end