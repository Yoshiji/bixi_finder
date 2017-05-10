class BixiStationsController < ApplicationController
  before_action :set_bixi_stations
  before_action :fetch_current_state_from_bixi_json_feed

  def index
  end

  def near_fx_innovation
    @distance_in_km ||= BIXI_FILTER_DISTANCE_BOUNDARIES[:range].max
  end

  def refresh
    BixiStation.refresh_stations
    redirect_to bixi_stations_path
  end


  protected

  def set_bixi_stations
    @bixi_stations = BixiStation.ordered

    if filtered_bixi_stations_params[:distance_in_km]
      if BIXI_FILTER_DISTANCE_BOUNDARIES[:range].include?(filtered_bixi_stations_params[:distance_in_km].to_f)
        @distance_in_km = filtered_bixi_stations_params[:distance_in_km].to_f
      else
        @distance_in_km = BIXI_FILTER_DISTANCE_BOUNDARIES[:range].max
      end
      @bixi_stations = @bixi_stations.max_distance_to_fx(@distance_in_km)
    end
  end

  def fetch_current_state_from_bixi_json_feed
    json = BixiStationFeedFetcher.new.execute
    selected_stations_official_identifiers = @bixi_stations.pluck(:official_identifier)
    filtered_json = json.select { |h| selected_stations_official_identifiers.include?(h['id']) }
    @current_state_by_official_identifier = filtered_json.group_by{ |h| h['id'].to_s }
  end

  def filtered_bixi_stations_params
    params.permit(:distance_in_km, :auto_reload_page)
  end
end