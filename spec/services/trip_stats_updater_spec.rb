require 'rails_helper'

describe TripStatsUpdater do
  let(:courier) do
    create(:courier)
  end

  let!(:old_daily_stat) do
    create(:daily_stat,
      date: '2012-12-01',
      courier_id: courier.id
    )
  end

  let(:trip) do
    create(:trip,
      price_cents: '1000',
      distance: 100,
      date: '2020-01-01',
      courier_id: courier.id
    )
  end

  let(:call) do
    described_class.new(trip: trip).call
  end

  describe 'create new daily_stat' do
    it do
      expect(DailyStat.count).to eq 1

      call

      created_daily_stat = DailyStat.find_by(date: trip.date)

      expect(DailyStat.count).to eq 2
      expect(created_daily_stat.total_distance).to eq 100
      expect(created_daily_stat.avg_ride).to eq 100
      expect(created_daily_stat.avg_price_cents).to eq 1000
      expect(created_daily_stat.total_price_cents).to eq 1000
      expect(created_daily_stat.trip_counter).to eq 1
    end
  end

  describe 'update daily_stat' do
    let!(:new_daily_stat) do
      create(:daily_stat,
        total_distance: 300,
        avg_ride: 300,
        avg_price_cents: '3000',
        total_price_cents: '3000',
        date: '2020-01-01',
        courier_id: courier.id,
        trip_counter: 1,
      )
    end

    it do
      expect { call }.not_to change{ DailyStat.count }
    end

    it do
      expect(new_daily_stat.total_distance).to eq 300
      expect(new_daily_stat.avg_ride).to eq 300
      expect(new_daily_stat.avg_price_cents).to eq 3000
      expect(new_daily_stat.total_price_cents).to eq 3000
      expect(new_daily_stat.trip_counter).to eq 1

      call

      expect(new_daily_stat.reload.total_distance).to eq 400
      expect(new_daily_stat.reload.avg_ride).to eq 200
      expect(new_daily_stat.reload.avg_price_cents).to eq 2000
      expect(new_daily_stat.reload.total_price_cents).to eq 4000
      expect(new_daily_stat.reload.trip_counter).to eq 2
    end
  end #update daily_stat
end
