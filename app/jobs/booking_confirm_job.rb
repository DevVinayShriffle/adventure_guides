class BookingConfirmJob < ApplicationJob
  queue_as :default

  def perform(booking)
    BookingMailer.booking_confirm(booking).deliver_now
  end
end
