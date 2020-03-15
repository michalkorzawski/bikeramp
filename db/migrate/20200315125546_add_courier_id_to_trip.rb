class AddCourierIdToTrip < ActiveRecord::Migration[6.0]
  def change
    add_column :trips, :courier_id, :integer, null: false
    add_index :trips, :courier_id
  end
end
