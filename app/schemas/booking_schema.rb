require 'dry/schema'

BookingSchema = Dry::Schema.Params do
  required(:schedule_id).filled(:integer)
  required(:seats).filled(:integer)
  required(:pickup).filled(:string)
  required(:drop).filled(:string)
end