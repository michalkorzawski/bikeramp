# frozen_string_literal: true

class WeeklyStatsSerializer < StatsBaseSerializer
  def as_json(*)
    {
      total_distance: total_distance(sum_total_distance),
      total_price: total_price(sum_total_price)
    }
  end

  private

  def sum_total_distance
    @stats.sum(:total_distance)
  end

  def sum_total_price
    @stats.map(&:total_price).sum
  end
end
