module Guide
  class BusesController < ApplicationController
    before_action :authorize_request
    before_action :require_guide
    before_action :set_bus, only: [:show, :update, :destroy]

    def index
      @buses = Bus.all.order(created_at: :desc)

      respond_to do |format|
        format.html
        format.json { render json: @buses, status: :ok }
      end
    end

    def show
      respond_to do |format|
        format.html
        format.json { render json: @bus, status: :ok }
      end
    end

    def create
      @bus = Bus.create!(bus_params)

      respond_to do |format|
        format.html { redirect_to guide_buses_path, notice: "Bus created." }
        format.json { render json: @bus, message: "Bus created.", status: :created }
      end
    end

    def update
      if bus_params[:images].present?
        @bus.images.purge
      end
      @bus.update!(bus_params)

      respond_to do |format|
        format.html { redirect_to guide_buses_path, notice: "Bus updated." }
        format.json { render json: @bus, message: "Bus updated.", status: :ok }
      end
    end

    def destroy
      @bus.destroy

      respond_to do |format|
        format.html { redirect_to guide_buses_path, notice: "Bus deleted." }
        format.json { render json: { message: "Bus deleted." }, status: :ok }
      end
    end

    private

    def set_bus
      @bus = Bus.find(params[:id])
    end

    def bus_params
      params.require(:bus).permit(:name, :bus_type, :capacity, :price, images: [])
    end

    def require_guide
      render json: { message: "Access denied." }, status: :forbidden unless @current_user&.guide?
    end
  end
end