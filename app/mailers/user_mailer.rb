class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome Email!!")
  end

  # def booking_reminder(booking)
  #   byebug
  #   @booking = booking
  #   @user = booking.user

  #   mail(
  #     to: @user.email, subject: "Reminder: You have a booking today")
  # end
end
