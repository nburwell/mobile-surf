module ApplicationHelper
  def using_geo_location?
    session[:geo] && session[:geo][:location].is_a?(Array)
  end
end
