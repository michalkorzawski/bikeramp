require 'rails_helper'

describe DistanceFetcher do
  let(:start_address) do
    'Plac+Europejski+2,Warszawa,Polska'
  end

  let(:destination_address) do
    'Plac+Dąbrowskiego+2,Warszawa,Polska'
  end

  let(:attr_data) do
    {
      start_address: start_address,
      destination_address: destination_address
    }
  end

  let(:origins) do
    { origins: start_address }.to_query
  end

  let(:destinations) do
    { destinations: destination_address }.to_query
  end

  let(:call) do
    described_class.new(**attr_data).call
  end

  before do
    stub_request(:get, "#{ENV['GOOGLE_DISTANCE_MATRIX_API_URL']}&#{origins}&#{destinations}&key=#{ENV['GOOGLE_MAPS_API_KEY']}")
      .to_return(
        status: 200,
        body: distance_response.to_json,
        headers: {}
      )

    stub_request(:get, "#{ENV['GOOGLE_DISTANCE_MATRIX_API_URL']}&#{origins}&#{destinations}&key=wrong_key")
      .to_return(
        status: 200,
        body: distance_response.to_json,
        headers: {}
      )
  end

  describe 'success' do
    let(:distance_response) do
      {
        "destination_addresses": [ "Plac Jana Henryka Dąbrowskiego 1, 00-002 Warszawa, Polska" ],
        "origin_addresses": [ "plac Europejski 2, 00-844 Warszawa, Polska" ],
        "rows": [
          {
              "elements": [
                {
                    "distance": {
                      "text": "1,8 mil",
                      "value": distance_value
                    },
                    "duration": {
                      "text": "9 min",
                      "value": 566
                    },
                    "status": "OK"
                }
              ]
          }
        ],
        "status": "OK"
      }
    end

    let(:distance_value) { 2823 }

    it do
      expect(call).to eq distance_value
    end
  end # success

  describe 'fail' do
    let(:distance_response) do
      {
        "destination_addresses": [],
        "error_message": "The provided API key is invalid.",
        "origin_addresses": [],
        "rows": [],
        "status": "REQUEST_DENIED"
      }
    end

    it do
      expect { call }.to raise_error(DistanceFetcher::RequestFailed)
    end
  end
end
