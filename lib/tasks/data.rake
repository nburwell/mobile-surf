namespace :data do
  desc "Runs post checkout tasks based on cluster & environment"
  task :populate => :environment do
    SurfSpot.destroy_all
    
    a = File.open('db/cali_spots.csv').read.split(/\n/);
    SURF_SPOTS = a.map {|l| l.split(/,/)};
    
    conn = Faraday.new(:url => 'http://magicseaweed.com') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    SURF_SPOTS.each do |msw_id, name, msw_name|
      response = conn.get msw_name + "/" + msw_id.to_s + "/"    
      if response.body.size >  33000
         matches = response.body.match(/geo">([0-9.-]*), ([0-9.-]*)<\/span>/)
         lat = matches[1]
         long =  matches[2]  
         puts [lat, long].inspect
         SurfSpot.create!(
            :latitude => lat,
            :longitude => long,
            :name => name,
            :msw_id => msw_id,
            :msw_name => msw_name
         ) 
         sleep 3;   
      end
    end
  end
end
