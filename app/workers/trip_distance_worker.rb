# frozen_string_literal: true

class TripDistanceWorker
  include Sidekiq::Worker
  include Mixins::StrFormatter

  def perform(trip_id)
    trip = Trip.find(Integer(trip_id))

    distance = distance(
      start_address: url_ready(trip.start_address),
      destination_address: url_ready(trip.destination_address)
    )

    trip.update!(distance: Integer(distance)) if distance
    update_stats(trip: trip)
  end

  private

  def distance(start_address:, destination_address:)
    DistanceFetcher.new(
      start_address: start_address,
      destination_address: destination_address
    ).call
  end

  def update_stats(trip:)
    TripStatsUpdater.new(trip: trip).call
  end
end
