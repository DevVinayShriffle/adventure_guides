class Booking < ApplicationRecord
  enum :status, { confirmed: 0, cancelled: 1 }
  
  validates :seats, presence:true, numericality: { greater_than: 0 }
  validates :total_price, presence:true, numericality: { greater_than_or_equal_to: 0 }
  validates :pickup, presence:true
  validates :drop, presence:true

  belongs_to :user
  belongs_to :schedule  
end
