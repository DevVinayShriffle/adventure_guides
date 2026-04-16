class BookingStruct < Dry::Struct
  attribute :schedule_id, Types::Integer
  attribute :seats, Types::Integer
  attribute :pickup, Types::String
  attribute :drop, Types::String
end