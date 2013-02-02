class SurfSpotsController < ApplicationController
  def index
    reset_session

    if params[:location]
      session[:location] = { :name => "Santa Barbara, CA" }.merge( params[:location] )
    end

    if session[:location]
      @spots = SurfSpot.find_by_lat_long( session[:latitude], session[:longitude] )
    end
  end

  def show
    @spot = SurfSpot.find(params[:id])
  end

  def reset
    reset_session
  end
end
