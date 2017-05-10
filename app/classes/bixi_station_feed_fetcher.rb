class BixiStationFeedFetcher

  def execute
    uri = URI(BIXI_JSON_FEED_URL)
    response = Net::HTTP.get(uri)
    JSON.parse(response)['stations']
  end

end