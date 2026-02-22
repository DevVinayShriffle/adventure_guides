class CreateBookings < ActiveRecord::Migration[8.1]
  def change
    create_table :bookings do |t|
      t.references :user, null:false, foreign_key:true
      t.references :schedule, null:false, foreign_key:true
      t.integer :seats, null:false
      t.decimal :total_price, precision: 10, scale: 2, null: false
      t.string :pickup, null:false
      t.string :drop, null:false

      t.timestamps
    end
  end
end
