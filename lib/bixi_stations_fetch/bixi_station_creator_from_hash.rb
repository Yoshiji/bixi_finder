class BixiStationCreatorFromHash
  attr_accessor :parsed_attrs
  # BixiStation model attributes:
  # official_identifier ; name ; terminal_identifier ; latitude ; longitude
  # Bixi.com JSON attrs:
  # id ; s ; n ; la ; lo
  def initialize(hash)
    hash = hash.stringify_keys
    self.parsed_attrs = {
      official_identifier: hash['id'],
      name:                hash['s'],
      terminal_identifier: hash['n'],
      latitude:            hash['la'],
      longitude:           hash['lo'],
    }
  end

  def create_record!
    BixiStation.create!(self.parsed_attrs) unless BixiStation.where(self.parsed_attrs.slice(:official_identifier)).exists?
  end
end