class BookingSerializer < ActiveModel::Serializer
  attributes :id, :seats, :pickup, :drop, :total_price, :status

  belongs_to :user
  belongs_to :schedule
end
