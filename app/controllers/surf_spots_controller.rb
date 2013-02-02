class SurfSpotsController < ApplicationController
  MAX_DISTANCE = 100

  before_filter :find_spots

  def index
    if session[:geo]
      @swell_chart = SwellChart.near( session[:geo][:location], 1000 ).limit(1).first
    end
  end

  def show
    @spot = SurfSpot.find(params[:id])
  end

  def reset
    reset_session
  end

  private

  def find_spots
    if params[:location]
      location_name = Geocoder.search(params[:location]).first.address
      session[:geo] = { :name => location_name, :location => params[:location] }
    end

    if session[:geo]
      @spots = SurfSpot.near( session[:geo][:location], MAX_DISTANCE ).limit(5)
    end
  end
end
