# frozen_string_literal: true

class StatsBaseSerializer
  include Mixins::StrFormatter

  def initialize(**opts)
    @stats = opts.fetch(:stats)
  end

  private

  def total_distance(stat_total_dis)
    meters_to_km(stat_total_dis)
  end

  def total_price(sum_total_price)
    price_format(sum_total_price)
  end
end
