class CreateDestinations < ActiveRecord::Migration[8.1]
  def change
    create_table :destinations do |t|
      t.string :name, null:false
      t.string :description
      t.string :location, null:false

      t.timestamps
    end
  end
end
