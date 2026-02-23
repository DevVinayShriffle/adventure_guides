# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
user_email = "admin@gmail.com"
user = User.find_or_create_by!(email: user_email) do |u|
	u.name = "Admin"
	u.email = "admin@gmail.com"
	u.password = "Admin@123"
	u.password_confirmation = "Admin@123"
	u.phone = "9999999999"
	u.role = "admin"
end

puts "User #{user.email} saved successfully."

Destination.find_or_create_by!(
  name: "Kailasa Temple (Cave 16)",
  description: "A 8th-century monolithic, rock-cut Hindu temple dedicated to Lord Shiva, carved from a single cliff face.",
  location: "Ellora Caves, Aurangabad District, Maharashtra, India"
)

Destination.find_or_create_by!(
  name: "Jaipur",
  location: "Rajasthan, India",
  description: "The capital of Rajasthan, known for its Pink City architecture, forts, and vibrant culture."
)

