class BookingConfirmedHandler
  def call(event)
    BookingConfirmJob.perform_later(event.data[:booking_id])
  end
end