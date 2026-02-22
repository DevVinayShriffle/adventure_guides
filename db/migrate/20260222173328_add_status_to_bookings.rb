class AddStatusToBookings < ActiveRecord::Migration[8.1]
  def change
    add_column :bookings, :status, :integer
  end
end
