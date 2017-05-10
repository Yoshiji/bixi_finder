class BixiStationsController < ApplicationController
  before_action :refresh_bixi_stations
  before_action :set_bixi_stations

  def index
  end

  def near_fx_innovation
    @values_for_form = { distance_in_km: 1, available_bikes: true }
    @values_for_form.merge!(filter_bixi_stations_params.slice(:distance_in_km, :available_bikes).to_hash.symbolize_keys)
    @values_for_form[:available_bikes] = @values_for_form[:available_bikes].to_s == 'true'
    @values_for_form[:distance_in_km] = 1 unless (BIXI_FILTER_DISTANCE_BOUNDARIES[:range]).include?(@values_for_form[:distance_in_km].to_f)

    @bixi_stations = @bixi_stations.max_distance_to_fx(@values_for_form[:distance_in_km])
    @bixi_stations = @bixi_stations.having_available_bikes if @values_for_form[:available_bikes]
  end


  protected


  def refresh_bixi_stations
    BixiStation.refresh_stations
  end

  def set_bixi_stations
    @bixi_stations = BixiStation.ordered
  end

  def filter_bixi_stations_params
    params.permit(:distance_in_km, :available_bikes)
  end
end