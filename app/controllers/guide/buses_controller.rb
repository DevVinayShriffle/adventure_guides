module Guide
  class BusesController < ApplicationController
    before_action :authenticate_user!
    before_action :require_guide
    before_action :set_bus, only: [:show, :update, :destroy, :edit]

    def index
      @buses = Bus.all.order(created_at: :desc)

      respond_to do |format|
        format.html
        format.json do
          if @buses.present?
            render json: @buses, status: :ok
          else
            render json: { message: "No buses found." }, status: :ok
          end
        end
      end
    end

    def show
      @bus
      respond_to do |format|
        format.html
        format.json { render json: @bus, status: :ok }
      end
    end

    def new
      @bus = Bus.new
    end

    def create
      @bus = bus_params
      @bus[:user_id] = current_user.id
      @bus = Bus.create!(@bus)

      flash[:notice] = "Bus created."
      respond_to do |format|
        format.html { redirect_to guide_buses_path }
        format.json { render json: @bus, message: "Bus created.", status: :created }
      end
    end

    def edit
      @bus
    end

    def update
      params[:bus].delete("images") if params[:bus][:images]==[""]
      
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
      @bus = current_user.buses.find(params[:id])
    end

    def bus_params
      params.require(:bus).permit(:name, :bus_type, :capacity, :price, images: [])
    end

    def require_guide
      render json: { message: "Access denied." }, status: :forbidden unless current_user&.guide?
    end
  end
end