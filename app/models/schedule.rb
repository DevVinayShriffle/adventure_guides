class Schedule < ApplicationRecord
  validates :arrival, presence: true
  
  validates :departure,
  presence: true,
  comparison: { greater_than: :arrival, message: "must be after the arrival." }

  belongs_to :bus
  belongs_to :destination
end
