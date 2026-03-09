class Guide::SchedulesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_guide
  before_action :set_schedule, only: [:update, :destroy, :edit]

  def index
    @schedules = Schedule.joins(:bus)
    .where(buses: { user_id: current_user.id })
    .includes(:bus, :destination)
    .order(departure: :asc)

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

  def new
    @schedule = Schedule.new
    @buses = Bus.where(user_id: current_user.id)
  end
  
  def create
    @bus = Bus.find_by(id: params[:schedule][:bus_id])
    params[:schedule][:available_seats]=@bus.capacity
    @schedule = schedules_params
    target = @bus.bus_stops.select(:name).where(stop_type: "drop")
    @schedule[:destination_id] = Destination.where("? ILIKE CONCAT('%', name, '%')", target.first.name).select(:id).first.id
    schedule = @bus.schedules.create!(@schedule)

    respond_to do |format|
      format.html { redirect_to guide_schedules_path, notice: "Bus schedule created." }
      format.json { render json: schedule, message: "Bus schedule created.", status: :created }
    end
  end

  def edit
    @schedule
  end

  def update
    @schedule.update!(schedules_params)

    respond_to do |format|
      format.html { redirect_to guide_schedules_path, notice: "Bus schedule updated." }
      format.json { render json: @schedule, message: "Schedule updated.", status: :ok }
    end
  end

  def destroy
    @schedule.destroy

    respond_to do |format|
      format.html { redirect_to guide_schedules_path, notice: "Bus schedule deleted." }
      format.json { render json: { message: "Schedule deleted." }, status: :ok }
    end
  end

  private

  def require_guide
    render json: { message: "Access denied." }, status: :forbidden unless current_user&.guide?
  end

  def schedules_params
    params.require(:schedule).permit(:arrival, :departure, :available_seats)
  end

  def set_schedule
    @schedule = Schedule.joins(:bus)
    .where(buses: { user_id: current_user.id })
    .find_by(id: params[:id])

    unless @schedule
      render json: { message: "Schedule not found." }, status: :not_found
    end
  end
end
