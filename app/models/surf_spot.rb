class SurfSpot < ActiveRecord::Base
  attr_accessible :lat, :long, :name, :msw_id, :msw_name

  def self.find_by_lat_long( lat, long )
    SurfSpot.all(:limit=>3)
  end

end
