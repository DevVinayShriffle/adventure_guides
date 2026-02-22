module Admin
  class DestinationsController < ApplicationController
    before_action :authorize_request
    before_action :require_admin
    before_action :set_destination, only: [:show, :update, :destroy]

    def index
      @destinations = Destination.all.order(created_at: :desc)

      respond_to do |format|
        format.html
        format.json { render json: { destinations: @destinations }, status: :ok }
      end
    end

    def show
      respond_to do |format|
        format.html
        format.json { render json: { destination: @destination }, status: :ok }
      end
    end

    def create
      @destination = Destination.create!(destination_params)

      respond_to do |format|
        format.html { redirect_to admin_destinations_path, notice: "Destination created." }
        format.json { render json: { destination: @destination, message: "Destination created." }, status: :created }
      end
    end

    def update
      @destination.update!(destination_params)

      respond_to do |format|
        format.html { redirect_to admin_destinations_path, notice: "Destination updated." }
        format.json { render json: { destination: @destination, message: "Destination updated." }, status: :ok }
      end
    end

    def destroy
      @destination.destroy

      respond_to do |format|
        format.html { redirect_to admin_destinations_path, notice: "Destination deleted." }
        format.json { render json: { message: "Destination deleted." }, status: :ok }
      end
    end

    private

    def set_destination
      @destination = Destination.find(params[:id])
    end

    def destination_params
      params.require(:destination).permit(:name, :description, :location, images: [])
    end

    def require_admin
      render json: { message: "Access denied." }, status: :forbidden unless @current_user&.admin?
    end
  end
end