namespace :booking do
  desc "Send Booking reminders to users"
  task send_reminders_emails: :environment do
    require 'byebug'
    bookings = Booking.where(status: "confirmed")

    bookings.each do |booking|
      if (booking.schedule.departure - 6.hours) <= Time.now
        BookingMailer.booking_reminder(booking).deliver_now
        puts "Enqueued Booking reminder email for #{booking.user}"
      end
    end
  end
end
