class CreateTrip < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.string :start_address,         null: false
      t.string :destination_address,   null: false
      t.integer :distance,             default: 0
      t.monetize :price,               default: 0
      t.datetime :date,                null: false

      t.timestamps
    end
  end
end
