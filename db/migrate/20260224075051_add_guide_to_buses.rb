class AddGuideToBuses < ActiveRecord::Migration[8.1]
  def change
    add_reference :buses, :user, null: false, foreign_key: true
  end
end
