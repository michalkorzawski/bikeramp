# frozen_string_literal: true

class MonthlyStatsSerializer < StatsBaseSerializer
  def as_json(*)
    @stats.map do |daily_stat|
      {
        day: day_format(daily_stat.date),
        total_distance: total_distance(daily_stat.total_distance),
        avg_ride: meters_to_km(daily_stat.avg_ride),
        avg_price: price_format(daily_stat.avg_price)
      }
    end
  end
end
