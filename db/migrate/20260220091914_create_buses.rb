class CreateBuses < ActiveRecord::Migration[8.1]
  def change
    create_table :buses do |t|
      t.string :name, null:false
      t.string :bus_type, null:false
      t.integer :capacity, null:false
      t.decimal :price, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
