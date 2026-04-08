module Guide
  class BusStopsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_guide
    before_action :set_bus
    before_action :set_bus_stop, only: [:show, :update, :destroy]

    def index
      bus_stops = @bus.bus_stops.order(created_at: :asc)
      
      respond_to do |format|
        format.html
        format.json do
          if bus_stops.present?
            render json: bus_stops, status: :ok
          else
            render json: { message: "No bus_stops found." }, status: :ok
          end
        end
      end
    end

    def new
      @bus_stop = BusStop.new
    end

    def show
      render json: @bus_stop, status: :ok
    end

    def create
      bus_stop = @bus.bus_stops.create!(bus_stop_params)
      
      respond_to do |format|
        format.html { redirect_to guide_bus_path(@bus), notice: "Bus stop created." }
        format.json { render json: bus_stop, message: "Bus stop created.", status: :created }
      end
    end

    def edit
      @bus_stop = @bus.bus_stops.find_by(id: params[:id])
    end

    def update
      @bus_stop.update!(bus_stop_params)
      
      respond_to do |format|
        format.html { redirect_to guide_bus_path(@bus), notice: "Bus stop updated." }
        format.json { render json: @bus_stop, message: "Bus stop updated.", status: :ok }
      end
    end

    def destroy
      @bus_stop.destroy
      
      respond_to do |format|
        format.html { redirect_to guide_bus_path(@bus), notice: "Bus stop Deleted." }
        format.json { render json: { message: "Bus stop deleted." }, status: :ok }
      end
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
      render json: { message: "Access denied." }, status: :forbidden unless current_user&.guide?
    end
  end
end