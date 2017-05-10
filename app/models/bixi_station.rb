class BixiStation < ApplicationRecord
	validates :official_identifier, :name, :terminal_identifier, :latitude, :longitude, presence: true
  validates :official_identifier, :name, :terminal_identifier, uniqueness: true
  validates :latitude, uniqueness: { scope: :longitude }
end
