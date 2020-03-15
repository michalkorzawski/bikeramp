class CreateDailyStat < ActiveRecord::Migration[6.0]
  def change
    create_table :daily_stats do |t|
      t.string :day,               null: false
      t.integer :total_distance,   default: 0
      t.integer :avg_ride,         default: 0
      t.monetize :avg_price,       default: 0
      t.monetize :total_price,     default: 0
      t.integer :courier_id,       null: false

      t.timestamps
    end
    add_index :daily_stats, :courier_id
    add_index :daily_stats, :day
  end
end
