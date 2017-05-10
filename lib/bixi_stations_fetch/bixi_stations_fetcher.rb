require 'net/http'
require 'json'
require 'bixi_station_creator_from_hash'

class BixiStationsFetcher

  def execute
    BixiStation.delete_all

    url = 'https://secure.bixi.com/data/stations.json'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    hashes = JSON.parse(response)['stations']
    hashes.each do |hash|
      BixiStationCreatorFromHash.new(hash).create_record!
    end
  end
end