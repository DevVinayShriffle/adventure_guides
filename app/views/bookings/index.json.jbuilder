json.array! @bookings do |booking|
	json.id booking.id
	json.seats booking.seats
	json.pickup booking.pickup
	json.drop booking.drop
	json.total_price booking.total_price

	json.user do
		json.name booking.user.name
		json.phone booking.user.phone
		json.email booking.user.email
	end

	json.schedule do
		json.id booking.schedule.id
		json.destination booking.schedule.destination.name
		json.arrival booking.schedule.arrival
		json.departure booking.schedule.departure
	end
end