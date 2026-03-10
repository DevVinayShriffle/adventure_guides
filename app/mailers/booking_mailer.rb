class BookingMailer < ApplicationMailer
  def booking_reminder(booking)
    
    @booking = booking
    @user = booking.user

    mail(to: @user.email, subject: "Reminder: You have a booking today")
  end
end
