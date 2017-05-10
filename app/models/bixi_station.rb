class BixiStation < ApplicationRecord
  reverse_geocoded_by :latitude, :longitude

	validates :official_identifier, :name, :terminal_identifier, :latitude, :longitude, presence: true
  validates :official_identifier, :name, :terminal_identifier, uniqueness: true
  validates :latitude, uniqueness: { scope: :longitude }


  scope :having_available_bikes, -> { where('available_bikes > 0') }
  scope :ordered, -> { order(:name) }
end
