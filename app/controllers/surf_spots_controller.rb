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

  def directions
    @spot = SurfSpot.find(params[:id])
  end

  private

  def find_spots
    if !params[:location].blank?
      location_name = Geocoder.search(params[:location]).first.try(:address)
      session[:geo] = { :name => location_name, :location => params[:location] } if location_name
    end

    if session[:geo]
      @spots = SurfSpot.near( session[:geo][:location], MAX_DISTANCE ).limit(5)
    end
  end
end
