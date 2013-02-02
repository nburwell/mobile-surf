namespace :data do
  desc "Runs post checkout tasks based on cluster & environment"
  task :populate => :environment do
    SurfSpot.destroy_all

    SURF_SPOTS = [
      [ 100, 200, "Ledbetter", "10", "leadbetter-report" ],
      [ 101, 220, "east-beach", "12", "east-beach-report" ],
      [ 121, 300, "rincon",     "300", "rincon-report" ],
    ]

    SURF_SPOTS.each do |lat, long, name, msw_id, msw_name|
      SurfSpot.create!(
        :lat => lat,
        :long => long,
        :name => name,
        :msw_id => msw_id,
        :msw_name => msw_name
      )
    end
  end
end