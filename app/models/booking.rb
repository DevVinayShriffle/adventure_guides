class Booking < ApplicationRecord
  enum :status, { confirmed: 0, cancelled: 1 }
  
  validates :seats, presence:true, numericality: { greater_than: 0 }
  validates :total_price, presence:true, numericality: { greater_than_or_equal_to: 0 }
  validates :pickup, presence:true
  validates :drop, presence:true

  belongs_to :user
  belongs_to :schedule

  after_create :confirm_booking_email
  after_create :schedule_reminder_email

  private

  def confirm_booking_email
    BookingConfirmJob.set(wait: 10.seconds).perform_later(self)
  end

  def schedule_reminder_email
    reminder_time = self.schedule.departure - 4.hours

    BookingReminderJob.set(wait_until: reminder_time).perform_later(self.id)
  end
end
