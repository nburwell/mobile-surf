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

  task :swell_charts  => :environment do
    SWELL_CHARTS = [
      {
        :url => "http://cdip.ucsd.edu/recent/model_images/sf.png",
        :latitude0	 =>	38.908798,
        :longitude0	 =>	-123.6930726,
        :latitude1	=>	37.1125987,
        :longitude1	 =>	-122.3135862,
      },
      {
        :url => "http://cdip.ucsd.edu/recent/model_images/monterey.png",
        :latitude0	 =>	37.1130031,
        :longitude0	=>	-122.3302506,
        :latitude1	 =>	36.2704212,
        :longitude1 =>	-121.807976,
      },
      {
        :url => "http://cdip.ucsd.edu/?nav=recent&sub=nowcast&units=metric&tz=UTC&pub=public&map_stati=1,2,3&xitem=conception",
        :latitude0	=>	36.0205172,
        :longitude0	 =>	-121.5674416,
        :latitude1	 =>	34.6391501,
        :longitude1	 =>	-120.4579409,
      },
      {
        :url =>"http://cdip.ucsd.edu/recent/model_images/sb_channel.png",
        :latitude0	=>	34.5772065,
        :longitude0	 =>	-120.6507263,
        :latitude1	=>	34.1975048,
        :longitude1	 =>	-119.1770516
      },
      {
        :url => "http://cdip.ucsd.edu/recent/model_images/santa_monica.png",
        :latitude0  =>	34.1477829,
        :longitude0	 =>	-119.1951074,
        :latitude1	 =>	33.7444613,
        :longitude1	 =>	-118.3870173,
      },
      {
        :url => "http://cdip.ucsd.edu/recent/model_images/san_pedro.png",
        :latitude0	 =>	33.7360619,
        :longitude0	 =>	-118.2922461,
        :latitude1	 =>	33.4198346,
        :longitude1	 =>	-117.5797304
      },
      {
        :url => "http://cdip.ucsd.edu/recent/model_images/san_diego.png",
        :latitude0  =>	33.2089729,
        :longitude0	=>	-117.3884433,
        :latitude1	 =>	32.6400541,
        :longitude1	 =>	-117.0841955
      }
    ]

    SwellChart.destroy_all
    SWELL_CHARTS.each do |v|
      puts v[:url]
      SwellChart.create!(
        :name      => "",
        :url       => v[:url],
        :latitude  => (v[:latitude0] + v[:latitude1]) / 2,
        :longitude => (v[:longitude0] + v[:longitude1]) / 2
      )
    end

  end
end
