class BusesController < ApplicationController
  before_action :set_bus, only: [:show]

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
    respond_to do |format|
      format.html
      format.json { render json: @bus, status: :ok }
    end
  end

  private

  def set_bus
    @bus = Bus.find(params[:id])
  end
end