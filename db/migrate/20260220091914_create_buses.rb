class CreateBuses < ActiveRecord::Migration[8.1]
  def change
    create_table :buses do |t|
      t.string :name, null:false
      t.string :type, null:false
      t.integer :capacity, null:false
      t.integer :price, null:false

      t.timestamps
    end
  end
end
