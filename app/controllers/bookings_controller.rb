class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :cancel]

  def index
    @bookings = current_user.bookings.includes(schedule: [:bus, :destination]).order(created_at: :desc)

    respond_to do |format|
      format.html
      format.json do
        if @bookings.present?
          render json: { bookings: @bookings.map { |booking| BookingSerializer.new(booking) }}, status: :ok
        else
          render json: { message: "No bookings found." }, status: :ok
        end
      end
    end
  end

  def new
    @schedule = Schedule.find_by(id: params[:schedule_id])

    unless @schedule
      redirect_to root_path, alert: "Schedule not found"
    end

    @booking = Booking.new
  end

  def show
    respond_to do |format|
      format.html
      format.json do
        if @booking.present?
          render json: @booking, status: :ok
        else
          render json: { message: "Booking not found." }, status: :not_found
        end
      end
    end
  end

  def create
    schedule = Schedule.find_by(id: booking_params[:schedule_id])

    unless schedule.present?
      return render json: { message: "Schedule not found." }, status: :not_found
    end

    if schedule.available_seats < booking_params[:seats].to_i
      return render json: { message: "Not enough seats available." }, status: :unprocessable_entity
    end

    # raise CustomError.new("Not enough seats available.", :unprocessable_entity) if schedule.available_seats < booking_params[:seats].to_i

    total_price = schedule.bus.price * booking_params[:seats].to_i

    booking = current_user.bookings.new(booking_params)
    booking.total_price = total_price
    booking.status = :confirmed

    ActiveRecord::Base.transaction do
      schedule.update!(available_seats: schedule.available_seats - booking.seats)
      booking.save!
    end

    respond_to do |format|
      format.html
      format.json do
        render json: {
          booking: BookingSerializer.new(booking),
          message: "Booking confirmed."
        }, status: :created
      end
    end
  end

  def cancel
    byebug
    if @booking.cancelled?
      return render json: { message: "Booking already cancelled." }, status: :unprocessable_entity
    end

    ActiveRecord::Base.transaction do
      @booking.schedule.update!(
        available_seats: @booking.schedule.available_seats + @booking.seats
      )
      @booking.update!(status: :cancelled)
    end

    respond_to do |format|
      format.html
      format.json do
        render json: {
          booking: BookingSerializer.new(@booking),
          message: "Booking cancelled successfully."
        }, status: :ok
      end
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:schedule_id, :seats, :pickup, :drop)
  end

  def set_booking
    @booking = current_user.bookings.find(params[:id])
  end
end