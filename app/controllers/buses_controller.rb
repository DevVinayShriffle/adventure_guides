class BusesController < ApplicationController
  before_action :set_bus, only: [:show]

  # def index
  #   @buses = Bus.all.order(created_at: :desc)

  #   respond_to do |format|
  #     format.html
  #     format.json do
  #       if @buses.present?
  #         render json: @buses, status: :ok
  #       else
  #         render json: { message: "No buses found." }, status: :ok
  #       end
  #     end
  #   end
  # end

  def index
    if params[:destination_id].present?
      @destination = Destination.find_by(id: params[:destination_id])

      if @destination.present?
        @buses = Bus.joins(:bus_stops)
                    .where(bus_stops: { stop_type: "drop", name: @destination.name })
                    .distinct
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
    respond_to do |format|
      format.html
      # format.json { render json: @bus, status: :ok }
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