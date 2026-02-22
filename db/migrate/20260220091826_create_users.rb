class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :name, null:false
      t.string :phone, limit: 15
      t.integer :role, default:0, null: false

      t.timestamps
    end
  end
end
