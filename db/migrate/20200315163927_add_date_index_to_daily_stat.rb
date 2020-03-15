class AddDateIndexToDailyStat < ActiveRecord::Migration[6.0]
  def change
    add_index :daily_stats, :date
  end
end
