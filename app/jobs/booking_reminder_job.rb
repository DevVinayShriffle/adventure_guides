class BookingReminderJob < ApplicationJob
  queue_as :default

  def perform(booking_id)
    booking = Booking.find_by(id: booking_id)
    return unless booking

    BookingMailer.booking_reminder(booking).deliver_now
  end
end
