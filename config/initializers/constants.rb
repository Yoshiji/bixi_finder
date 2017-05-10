# can easily add more coords there
# could be transferred to a model with persisted records (FavoriteLocation)
# and be used to compute distance between each BixiStation and FavoriteLocation in another table
FAVORITE_LAT_LON = {
  fx_innovation: [45.506318, -73.569021],
}.freeze

BIXI_JSON_FEED_URL = 'https://secure.bixi.com/data/stations.json'.freeze

BIXI_FILTER_DISTANCE_BOUNDARIES = {
  range: 0.1..99.0,
  step: 0.1,
}.freeze

AUTO_RELOAD_BIXI_STATIONS_PAGE_DELAY_IN_MS = 10000