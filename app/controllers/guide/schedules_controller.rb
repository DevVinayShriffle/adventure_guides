class Guide::SchedulesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_guide
  before_action :set_bus, except: [:show]
  before_action :set_schedule, only: [:show, :update, :destroy, :edit]

  def new
    @schedule = Schedule.new
  end

  def index
    # @schedules = Schedule.includes(:bus, :destination).order(departure: :asc)
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
    params[:schedule][:available_seats]=@bus.capacity
    @schedule = schedules_params
    target = @bus.bus_stops.select(:name).where(stop_type: "drop")
    @schedule[:destination_id] = Destination.where("? ILIKE CONCAT('%', name, '%')", target.first.name).select(:id).first.id
    schedule = @bus.schedules.create!(@schedule)

    respond_to do |format|
      format.html { redirect_to guide_bus_path(@bus) }
      format.json { render json: schedule, message: "Bus schedule created.", status: :created }
    end
  end

  # def create
  #   byebug
  #   drop_stop = @bus.bus_stops.find_by(stop_type: "drop")

  #   unless drop_stop
  #     return render json: { message: "Drop stop not found." }, status: :unprocessable_entity
  #   end

  #   destination = Destination.find_by("name ILIKE ?", "%#{drop_stop.name}%")

  #   unless destination
  #     return render json: { message: "Matching destination not found." }, status: :unprocessable_entity
  #   end

  #   schedule = @bus.schedules.new(schedules_params)
  #   schedule.destination_id = destination.id

  #   if schedule.save
  #     render json: {
  #       schedule: ScheduleSerializer.new(schedule),
  #       message: "Bus schedule created."
  #     }, status: :created
  #   else
  #     render json: { errors: schedule.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end

  def edit
    @schedule
  end

  def update
    @schedule.update!(schedules_params)

    respond_to do |format|
      format.html { redirect_to guide_bus_path(@bus) }
      format.json { render json: @schedule, message: "Schedule updated.", status: :ok }
    end
  end

  def destroy
    @schedule.destroy

    respond_to do |format|
      format.html { redirect_to guide_bus_path(@bus) }
      format.json { render json: { message: "Schedule deleted." }, status: :ok }
    end
  end

  private

  # def set_bus
  #   @bus = Bus.find(params[:bus_id])
  # end

  def set_bus
    @bus = current_user.buses.find_by(id: params[:bus_id])

    unless @bus
      render json: { message: "Bus not found." }, status: :not_found
    end
  end

  # def set_schedule
  #   @schedule = Schedule.find_by(id: params[:id])
  # end

  def set_schedule
    @schedule = Schedule.joins(:bus)
    .where(buses: { user_id: current_user.id })
    .find_by(id: params[:id])

    unless @schedule
      render json: { message: "Schedule not found." }, status: :not_found
    end
  end

  def schedules_params
    params.require(:schedule).permit(:arrival, :departure, :available_seats)
  end

  def require_guide
    render json: { message: "Access denied." }, status: :forbidden unless current_user&.guide?
  end  
end
