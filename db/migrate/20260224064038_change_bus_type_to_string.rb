class ChangeBusTypeToString < ActiveRecord::Migration[8.1]
  def up
    change_column :buses, :bus_type, :integer, using: 'bus_type::integer', null: false
  end

  def down
    change_column :buses, :bus_type, :string, null: false
  end
end
