# frozen_string_literal: true

class TripStatsUpdater
  def initialize(**opts)
    @trip = opts.fetch(:trip)
    @courier = @trip.courier
  end

  def call
    daily_stat.update!(
      total_distance: total_distance,
      total_price_cents: total_price_cents,
      avg_price_cents: avg(total_price_cents),
      avg_ride: avg(total_distance),
      trip_counter: trip_counter
    )
  end

  private

  def total_distance
    daily_stat.total_distance + @trip.distance
  end

  def total_price_cents
    daily_stat.total_price_cents + @trip.price_cents
  end

  def trip_counter
    daily_stat.trip_counter + 1
  end

  def avg(total)
    total / trip_counter
  end

  def daily_stat
    @daily_stat ||= begin
      DailyStat.find_or_create_by(
        date: @trip.date,
        courier_id: @courier.id
      )
    end
  end
end
