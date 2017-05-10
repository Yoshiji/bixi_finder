class BixiStationsController < ApplicationController
  before_action :set_bixi_stations

  def index
  end

  def refresh
    BixiStationsFetcher.new.execute
    redirect_to bixi_stations_path
  end

  def near_fx_innovation # both GET
    @values_for_form = { distance_in_km: 1, available_bikes: true }
    @values_for_form.merge!(filter_bixi_stations_params.slice(:distance_in_km, :available_bikes).to_hash.symbolize_keys)
    @values_for_form[:available_bikes] = @values_for_form[:available_bikes].to_s == 'true' # nil.to_s => ''
    fx_innovation_coords = [45.506318, -73.569021] # provided by technical test description
    @bixi_stations = @bixi_stations.near(fx_innovation_coords, @values_for_form[:distance_in_km])
    @bixi_stations = @bixi_stations.having_available_bikes if @values_for_form[:available_bikes]
  end


  protected


  def set_bixi_stations
    @bixi_stations = BixiStation.ordered
  end

  def filter_bixi_stations_params
    params.permit(:distance_in_km, :available_bikes)
  end
end