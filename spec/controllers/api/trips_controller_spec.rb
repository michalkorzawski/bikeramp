require 'rails_helper'

describe Api::TripsController do
  describe '#create' do

    let(:params) do
      {
        trip: {
          start_address: start_address,
          destination_address: destination_address,
          price: price,
          date: date
        }
      }
    end

    let(:start_address) { 'start_address' }
    let(:destination_address) { 'destination_address' }
    let(:price) { '10' }
    let(:date) { '2018-04-03' }

    let(:call) do
      post :create, params: params
    end

    context 'success' do
      context 'check if new Trip instance is created' do
        it do
          call
          expect(Trip.count).to eq 1
          expect(Trip.last.start_address).to eq start_address
          expect(Trip.last.destination_address).to eq destination_address
          expect(Trip.last.price).to eq Money.new(Integer(price) * 100)
          expect(Trip.last.date).to eq date.to_date
          expect(response).to have_http_status(:ok)
        end

        it do
          expect {
            TripDistanceWorker.perform_async(1)
          }.to change(TripDistanceWorker.jobs, :size).by(1)
        end
      end # check if new Trip instance is created
    end #success

    context 'fail' do
      let(:call) { post :create, params: fail_params }

      context 'attrs validation fail' do
        let(:fail_params) do
          params.tap{ |params| params[:trip].delete(:date) }
        end

        it do
          call

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end # attrs validation fail
    end # fail
  end # create
end
