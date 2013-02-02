class SwellChart < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :name, :url, :updated_at, :created_at, :id, :address

  reverse_geocoded_by :latitude, :longitude

end
