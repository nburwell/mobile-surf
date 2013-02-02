class SurfSpotsController < ApplicationController
  MAX_DISTANCE = 100000

  def index
    reset_session

    if params[:location]
      location_name = Geocoder.search(params[:location]).first.address
      session[:geo] = { :name => location_name, :location => params[:location] }
    end

    if session[:geo]
      @spots = SurfSpot.near( session[:geo][:location], MAX_DISTANCE )
    end
  end

  def show
    @spot = SurfSpot.find(params[:id])
  end

  def reset
    reset_session
  end
end
