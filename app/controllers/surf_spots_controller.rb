class SurfSpotsController < ApplicationController

  def index
    # look up
    @spots = []
  end

  def show
    # @spot = Spot.find(params[:id])
    @spot = { :name => "Chris' fav spot" }
  end
end
