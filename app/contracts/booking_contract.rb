class BookingContract < Dry::Validation::Contract
  params(BookingSchema)

  rule(:seats) do
    key.failure('must be greater than 0') if value <= 0
  end
end