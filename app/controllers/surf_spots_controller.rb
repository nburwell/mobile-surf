class SurfSpotsController < ApplicationController
  def index
    reset_session

    if params[:location]
      session[:geo] = { :name => "Santa Barbara, CA", :location => params[:location] }
    end

    if session[:geo]
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
