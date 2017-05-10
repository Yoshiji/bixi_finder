class BixiStationsRefresher

  def execute
    # removing existing BixiStation & reset primary key (id)
    BixiStation.reset_table

    # get JSON
    json = BixiStationFeedFetcher.new.execute

    # map JSON to BixiStation model attrs
    json_mapped_to_model_attrs = map_json_to_model_hash_attrs(json)

    # create BixiStation records
    BixiStation.create(json_mapped_to_model_attrs)
    # => Rails' built-in insert takes ~2200 ms for 539 records to insert, 1 SQL insert per element
    #BixiStation.bulk_insert(values: json_mapped_to_model_attrs, set_size: 1000)
    # => bulk_insert takes ~25 ms for 539 records to insert, 1 SQL insert statement for each batch of 1000 elements
    # => downside: no callbacks is triggered, but Computers are gods in math calculations so the distance to FX can be compute for very little performances
  end

  def map_json_to_model_hash_attrs(array_of_stations_hash)
    array_of_stations_hash.map do |hash|
      {
        official_identifier:       hash['id'],
        name:                      hash['s'],
        terminal_identifier:       hash['n'],
        latitude:                  hash['la'],
        longitude:                 hash['lo'],
        #useable:                   (hash['b'] || hash['su'] || hash['m']).blank?, # b: blocked, su: suspended, m: out of order
        #available_bikes:           hash['ba'],
        #bixi_checked_at:           Time.at(hash['lc']/1000).to_datetime, # miliseconds after 1970-01-01 00:00:00
        #distance_to_fx_innovation: Geocoder::Calculations.distance_between(FAVORITE_LAT_LON[:fx_innovation], [hash['la'], hash['lo']]).round(3), # callback triggered
      }
    end
  end
end