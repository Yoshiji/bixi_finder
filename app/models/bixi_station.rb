class BixiStation < ApplicationRecord
  reverse_geocoded_by :latitude, :longitude

	validates :official_identifier, :name, :terminal_identifier, :latitude, :longitude, presence: true
  #validates :official_identifier, :name, :terminal_identifier, uniqueness: true # I trust Bixi's feed to provide unique records
  #validates :latitude, uniqueness: { scope: :longitude } # I trust Bixi's feed to provide unique records

  scope :having_available_bikes, -> { where('available_bikes > 0') }
  scope :max_distance_to_fx, -> (distance_in_km) { where('distance_to_fx_innovation < ?', distance_in_km) }
  scope :ordered, -> { order(:distance_to_fx_innovation) }

  # I like to append "_before_save" to my callbacks so when my model becomes fat (because Rails), I know when my method is called
  before_save :compute_distance_to_fx_before_save, if: -> { self.latitude_changed? || self.longitude_changed? }


  def self.refresh_stations
    BixiStation.delete_all
    BixiStationsRefresher.new.execute
  end

  protected

  def compute_distance_to_fx_before_save
    self.distance_to_fx_innovation = Geocoder::Calculations.distance_between(FAVORITE_LAT_LON[:fx_innovation], [self.latitude, self.longitude]).round(3)
  end
end
