class AddTripCounterToDailyStat < ActiveRecord::Migration[6.0]
  def change
    add_column :daily_stats, :trip_counter, :integer, default: 0
  end
end
