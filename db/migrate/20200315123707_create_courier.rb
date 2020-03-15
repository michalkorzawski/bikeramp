class CreateCourier < ActiveRecord::Migration[6.0]
  def change
    create_table :couriers do |t|
      t.string :first_name,     null: false

      t.timestamps
    end
  end
end
