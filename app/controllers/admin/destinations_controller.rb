module Admin
  class DestinationsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin
    before_action :set_destination, only: [:show, :update, :destroy, :edit]

    def index
      @destinations = Destination.order(created_at: :desc)
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

    def new
      @destination = Destination.new
    end

    def edit
      @destination
    end

    def show
      respond_to do |format|
        format.html
        format.json { render json: @destination, status: :ok }
      end
    end

    def create
      @destination = Destination.create!(destination_params)

      respond_to do |format|
        format.html { redirect_to admin_destinations_path, notice: "Destination created." }
        format.json { render json: @destination, message: "Destination created." , status: :created }
      end
    end

    def update
      params[:destination].delete("images") if params[:destination][:images]==[""]
      
      @destination.update!(destination_params)

      respond_to do |format|
        format.html { redirect_to admin_destinations_path, notice: "Destination updated." }
        format.json { render json: @destination, message: "Destination updated.", status: :ok }
      end
    end

    def destroy
      @destination.destroy

      respond_to do |format|
        format.html { redirect_to admin_destinations_path, notice: "Destination deleted." }
        format.json { render json: { message: "Destination deleted." }, status: :ok }
      end
    end

    def all_users
      return if request.get?
      @users = User.order(created_at: :desc)

      respond_to do |format|
        format.html
        format.json { render json: { users: @users }, status: :ok }
      end
    end

    private

    def set_destination
      @destination = Destination.find_by(id: params[:id])
      render json: {message: "Destination not found."} unless @destination.present?
    end

    def destination_params
      params.require(:destination).permit(:name, :description, :location, images: [])
    end

    def require_admin
      render json: { message: "Access denied." }, status: :forbidden unless current_user&.admin?
    end
  end
end