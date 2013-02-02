class SwellChart < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :name, :url

  reverse_geocoded_by :latitude, :longitude

end
