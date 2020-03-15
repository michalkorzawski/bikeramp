class ChangeDayInDailyStats < ActiveRecord::Migration[6.0]
  def up
    remove_column :daily_stats, :day
    add_column :daily_stats, :date, :datetime, null: false
  end

  def down
    remove_column :daily_stats, :date
    add_column :daily_stats, :day, :string, null: false
  end
end
