class Booking < ApplicationRecord
  enum :status, { confirmed: 0, cancelled: 1 }
  
  validates :seats, presence:true, numericality: { greater_than: 0 }
  validates :total_price, presence:true, numericality: { greater_than_or_equal_to: 0 }
  validates :pickup, presence:true
  validates :drop, presence:true

  belongs_to :user
  belongs_to :schedule

  # after_create :schedule_reminder_email

  private

  def schedule_reminder_email
    reminder_time = booking_datetime - 4.hours

    BookingReminderJob.set(wait_until: reminder_time).perform_later(self.id)
  end
end
