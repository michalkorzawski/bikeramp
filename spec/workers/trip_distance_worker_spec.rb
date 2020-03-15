require 'rails_helper'

describe TripDistanceWorker do
  let(:trip) { create(:trip, distance: 0) }
  let(:distance) { 1000 }

  let(:call) { described_class.new.perform(trip.id) }

  context 'success' do
    before do
      allow_any_instance_of(DistanceFetcher)
        .to receive(:call)
        .and_return(distance)
    end

    it do
      expect(trip.distance).to eq 0
      call
      expect(trip.reload.distance).to eq distance
    end
  end

  context 'fail' do
    before do
      allow_any_instance_of(DistanceFetcher)
        .to receive(:call)
        .and_raise(DistanceFetcher::RequestFailed)
    end

    it do
      expect { call }.to raise_error(DistanceFetcher::RequestFailed)
    end
  end
end
