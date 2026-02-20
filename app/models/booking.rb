class Booking < ApplicationRecord
  validates :seat, presence:true
  validates :price, presence:true
  validates :pickup, presence:true
  validates :drop, presence:true

  belongs_to :user
  belongs_to :schedule  
end
