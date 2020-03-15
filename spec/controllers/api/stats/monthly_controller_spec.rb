require 'rails_helper'

describe Api::Stats::MonthlyController do
  describe '#index' do

    let(:call) { get :index }
    let!(:courier) { create(:courier) }

    context 'with stats collection' do
      before do
        allow(Date).to receive(:today) { '2017-05-15'.to_date }
      end

      (10..14).each do |index|
        let!(:"daily_stat_week5_#{index}") do
          create(:daily_stat,
            date: "2017-05-#{index}",
            total_distance: 1000,
            avg_ride: 500,
            avg_price_cents: '5000',
            total_price_cents: '10000',
            courier_id: courier.id
          )
        end
      end
      (10..26).each do |index|
        let!(:"daily_stat_week6_#{index}") do
          create(:daily_stat,
            total_distance: 1000,
            total_price_cents: '10000',
            date: "2017-06-#{index}",
            courier_id: courier.id
          )
        end
      end
      (10..26).each do |index|
        let!(:"daily_stat_week4_#{index}") do
          create(:daily_stat,
            total_distance: 1000,
            total_price_cents: '10000',
            date: "2017-04-#{index}",
            courier_id: courier.id
          )
        end
      end

      let(:expected_response) do
        (0..4).map do |i|
          {
            day: "May, 1#{i}th",
            total_distance: '1km',
            avg_ride: '0.5km',
            avg_price: '50PLN',
          }
        end
      end

      it do
        call
        expect(parse_response(response)).to eq expected_response
      end
    end # with stats collection

    context 'with empty collection' do
      before do
        allow(Date).to receive(:today) { '2018-11-15'.to_date }
      end

      it do
        call
        expect(parse_response(response)).to eq []
      end
    end # with empty collection
  end # index
end
