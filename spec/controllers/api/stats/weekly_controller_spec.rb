require 'rails_helper'

describe Api::Stats::WeeklyController do
  describe '#index' do

    let(:call) { get :index }

    let!(:courier) { create(:courier) }

    context 'with stats collection' do
      before do
        allow(Date).to receive(:today) { '2017-05-15'.to_date }
      end

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

      it do
        call
        expect(parse_response(response)).to eq expected_response
      end
    end # with stats collection

    context 'with empty collection' do
      before do
        allow(Date).to receive(:today) { '2018-11-15'.to_date }
      end

      let(:expected_response) do
        {
          total_distance: '0km',
          total_price: '0PLN'
        }
      end

      it do
        call
        expect(parse_response(response)).to eq expected_response
      end
    end # with empty collection
  end # index
end
