class BookingsController < ApplicationController
  before_action :authorize_request
  before_action :set_booking, only: [:show]

  def index
    @bookings = @current_user.bookings
                             .includes(:schedule)
                             .order(created_at: :desc)

    respond_to do |format|
      format.html
      format.json do
        if @bookings.present?
          render json: { bookings: @bookings }, status: :ok
        else
          render json: { message: "No bookings found." }, status: :ok
        end
      end
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json do
        render json: { booking: @booking, message: "Booking fetched successfully." }, status: :ok
      end
    end
  end

  def create
    ActiveRecord::Base.transaction do
      @schedule = Schedule.find(params[:booking][:schedule_id])

      seats_requested = params[:booking][:seats].to_i

      if seats_requested <= 0
        render json: { message: "Seats must be greater than zero." }, status: :unprocessable_entity
        raise ActiveRecord::Rollback
      end

      if @schedule.available_seats < seats_requested
        render json: { message: "Not enough seats available." }, status: :unprocessable_entity
        raise ActiveRecord::Rollback
      end

      total_price = seats_requested * @schedule.price

      @booking = @current_user.bookings.create!(
        schedule_id: @schedule.id,
        seats: seats_requested,
        total_price: total_price
      )

      @schedule.update!(
        available_seats: @schedule.available_seats - seats_requested
      )
    end

    respond_to do |format|
      format.html { redirect_to bookings_path, notice: "Booking created successfully." }
      format.json do
        render json: {
          booking: @booking,
          message: "Booking created successfully."
        }, status: :created
      end
    end
  end

  def cancel
    @booking = @current_user.bookings.find(params[:id])

    if @booking.cancelled?
      return render json: { message: "Booking already cancelled." }, status: :unprocessable_entity
    end

    ActiveRecord::Base.transaction do
      schedule = @booking.schedule

      # refund seats
      schedule.update!(
        available_seats: schedule.available_seats + @booking.seats
      )

      # update booking status
      @booking.update!(status: :cancelled)
    end

    respond_to do |format|
      format.html { redirect_to bookings_path, notice: "Booking cancelled successfully." }
      format.json { render json: { message: "Booking cancelled successfully." }, status: :ok }
    end
  end

  private

  def set_booking
    @booking = @current_user.bookings.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:schedule_id, :seats)
  end
end