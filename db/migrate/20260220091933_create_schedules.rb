class CreateSchedules < ActiveRecord::Migration[8.1]
  def change
    create_table :schedules do |t|
      t.references :bus, null:false, foreign_key:true
      t.references :destination, null:false, foreign_key:true
      t.string :arrival, null:false
      t.string :departure, null:false

      t.timestamps
    end
  end
end
