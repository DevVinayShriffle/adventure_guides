class Schedule < ApplicationRecord
  validates :arrival, presence: true
  
  validates :departure,
  presence: true,
  comparison: { less_than: :arrival, message: "must be before arrival." }

  validates :available_seats, presence: true, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :bus
  belongs_to :destination
  has_many :bookings, dependent: :destroy
end
