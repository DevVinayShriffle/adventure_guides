class CreateBusStops < ActiveRecord::Migration[8.1]
  def change
    create_table :bus_stops do |t|
      t.references :bus, null: false, foreign_key: true
      t.string :name, null: false
      t.string :stop_type, null: false
      
      t.timestamps
    end
  end
end
