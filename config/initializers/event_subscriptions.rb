require Rails.root.join("app/subscribers/booking_confirmed_handler")
require Rails.root.join("app/events/booking_created")

require Rails.root.join("app/subscribers/user_registered_handler")
require Rails.root.join("app/events/user_registered")

Rails.configuration.event_store.subscribe(
  BookingConfirmedHandler.new,
  to: [BookingCreated]
  )

Rails.configuration.event_store.subscribe(
  UserRegisteredHandler.new,
  to: [UserRegistered]
  )