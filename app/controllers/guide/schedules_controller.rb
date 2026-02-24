class Guide::SchedulesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_guide
  before_action :set_bus, except: [:show]
  before_action :set_schedule, only: [:show, :update, :destroy]

  def index
    @schedules = Schedule.includes(:bus, :destination).order(departure: :asc)

    respond_to do |format|
      format.html
      format.json do
        if @schedules.present?
          render json: @schedules, status: :ok
        else
          render json: { message: "No schedules found." }, status: :ok
        end
      end
    end
  end

  def show
    respond_to do |format|
      format.html
      
      format.json do
        if @schedule.present?
          render json: @schedule, status: :ok
        else
          render json: { message: "No schedules found." }, status: :ok
        end
      end
    end
  end

  def create
    @schedule = schedules_params
    target = @bus.bus_stops.select(:name).where(stop_type: "drop")
    @schedule[:destination_id] = Destination.where("? ILIKE CONCAT('%', name, '%')", target.first.name).select(:id).first.id
    schedule = @bus.schedules.create!(@schedule)

    respond_to do |format|
      format.html
      format.json { render json: schedule, message: "Bus schedule created.", status: :created }
    end
  end

  def update
    @bus_stop.update!(bus_stop_params)

    respond_to do |format|
      format.html
      format.json { render json: @bus_stop, message: "Bus stop updated.", status: :ok }
    end
  end

  def destroy
    @schedule.destroy

    respond_to do |format|
      format.html
      format.json { render json: { message: "Schedule deleted." }, status: :ok }
    end
  end

  private

  def set_bus
    @bus = Bus.find(params[:bus_id])
  end

  def set_schedule
    @schedule = Schedule.find_by(id: params[:id])
  end

  def schedules_params
    params.require(:schedule).permit(:arrival, :departure, :available_seats)
  end

  def require_guide
    render json: { message: "Access denied." }, status: :forbidden unless current_user&.guide?
  end  
end
