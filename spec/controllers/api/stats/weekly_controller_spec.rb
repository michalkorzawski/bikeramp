require 'rails_helper'

describe Api::Stats::WeeklyController do
  describe '#index' do
    before do
      allow(Date).to receive(:today) { '2017-05-15'.to_date }
    end

    let(:courier) { create(:courier) }

    (10..26).each do |index|
      let!(:"daily_stat_week1_#{index}") do
        create(:daily_stat,
          total_distance: 1000,
          total_price_cents: '10000',
          date: "2017-05-#{index}",
          courier_id: courier.id
        )
      end
    end

    let(:expected_response) do
      {
        total_distance: '7km',
        total_price: '700PLN'
      }
    end

    let(:call) { get :index }

    it do
      call
      expect(parse_response(response)).to eq expected_response
    end
  end # index
end
