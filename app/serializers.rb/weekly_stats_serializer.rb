# frozen_string_literal: true

class WeeklyStatsSerializer
  include Mixins::StrFormatter

  def initialize(**opts)
    @stats = opts.fetch(:stats)
  end

  def as_json(*)
    {
      total_distance: total_distance,
      total_price: total_price
    }
  end

  private

  def total_distance
    meters_to_km(@stats.sum(:total_distance))
  end

  def total_price
    price_format(@stats.map(&:total_price).sum)
  end
end
