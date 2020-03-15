# frozen_string_literal: true

class DistanceFetcher
  API_URL = ENV['GOOGLE_DISTANCE_MATRIX_API_URL']
  API_KEY = ENV['GOOGLE_MAPS_API_KEY']

  RequestFailed = Class.new(StandardError)

  def initialize(**opts)
    @start_address = opts.fetch(:start_address)
    @destination_address = opts.fetch(:destination_address)
  end

  def call
    res = JSON.parse(Net::HTTP.get(uri))
    status = res.fetch('status', 'REQUEST_DENIED')

    raise RequestFailed unless status == 'OK'

    # fetch distance val from response
    res['rows'].first['elements'].first['distance']['value']
  end

  private

  def uri
    @uri ||= begin
      URI.parse("#{API_URL}&#{origins}&#{destinations}&key=#{API_KEY}")
    end
  end

  def origins
    { origins: @start_address }.to_query
  end

  def destinations
    { destinations: @destination_address }.to_query
  end
end
