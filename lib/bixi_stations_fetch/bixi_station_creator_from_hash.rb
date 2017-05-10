class BixiStationCreatorFromHash
  attr_accessor :parsed_attrs
  # BixiStation model attributes:
  # official_identifier ; name ; terminal_identifier ; latitude ; longitude ; useable ; available_bikes ; last_checked_at
  # Bixi.com JSON attrs:
  # id ; s ; n ; la ; lo ; (b || su || m) ; ba ;
  def initialize(hash)
    hash = hash.stringify_keys
    self.parsed_attrs = {
      official_identifier: hash['id'],
      name:                hash['s'],
      terminal_identifier: hash['n'],
      latitude:            hash['la'],
      longitude:           hash['lo'],
      useable:             (hash['b'] || hash['su'] || hash['m']).blank?, # b: blocked, su: suspended, m: out of order
      available_bikes:     hash['ba'],
      last_checked_at:     Time.at(hash['lc']/1000).to_datetime, # miliseconds after 01.01.1970
    }
  end

  def create_record!
    BixiStation.create!(self.parsed_attrs) unless BixiStation.where(self.parsed_attrs.slice(:official_identifier)).exists?
  end
end