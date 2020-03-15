# frozen_string_literal: true

module Api
  class TripsController < ApplicationController
    def create
      Trip.create!(trip_attrs).tap do |trip|
        TripDistanceWorker.perform_async(trip.id)
      end

      head :ok
    end

    private

    def trip_attrs
      params.require(:trip).permit(
        :start_address,
        :destination_address,
        :price,
        :date
      )
    end
  end
end
