class BixiStationsController < ApplicationController
  def index
    @bixi_stations = BixiStation.all
  end

  def fetch
    BixiStationsFetcher.new.execute
    redirect_to root_path
  end

  def refresh
    BixiStation.destroy_all
    BixiStationsFetcher.new.execute
    redirect_to root_path
  end
end