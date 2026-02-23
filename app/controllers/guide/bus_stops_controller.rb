module Guide
  class BusStopsController < ApplicationController
    before_action :authorize_request
    before_action :require_guide
    before_action :set_bus
    before_action :set_bus_stop, only: [:show, :update, :destroy]

    def index
      bus_stops = @bus.bus_stops.order(created_at: :asc)
      render json: bus_stops, status: :ok
    end

    def show
      render json: @bus_stop, status: :ok
    end

    def create
      bus_stop = @bus.bus_stops.create!(bus_stop_params)
      render json: bus_stop, message: "Bus stop created.", status: :created
    end

    def update
      @bus_stop.update!(bus_stop_params)
      render json: @bus_stop, message: "Bus stop updated.", status: :ok
    end

    def destroy
      @bus_stop.destroy
      render json: { message: "Bus stop deleted." }, status: :ok
    end

    private

    def set_bus
      @bus = Bus.find(params[:bus_id])
    end

    def set_bus_stop
      @bus_stop = @bus.bus_stops.find(params[:id])
    end

    def bus_stop_params
      params.require(:bus_stop).permit(:name, :stop_type)
    end

    def require_guide
      render json: { message: "Access denied." }, status: :forbidden unless @current_user&.guide?
    end
  end
end