class CreateSchedules < ActiveRecord::Migration[8.1]
  def change
    create_table :schedules do |t|
      t.references :bus, null:false, foreign_key:true
      t.references :destination, null:false, foreign_key:true
      t.datetime :arrival, null:false
      t.datetime :departure, null:false
      t.integer :available_seats, null:false

      t.timestamps
    end
  end
end
