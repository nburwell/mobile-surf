class SurfSpot < ActiveRecord::Base
  attr_accessible :lat, :long, :name, :msw_id, :msw_name

  def self.find_by_lat_long( lat, long )
    SurfSpot.all(:limit=>3)
  end

  def msw_widget_embed
    msw_widget_embed_template % [ msw_name, msw_id, name ]
  end

  private

  def msw_widget_embed_template
'<!-- This code is issued by Magicseaweed.com under license 1359784508_95420 for the website  only subject to terms and conditions
and this message being kept intact as part of the code. If you are not the license holder add this content to your website by registering at
Magicseaweed.com. All copyrights retained by Metcentral Ltd and any attempt to modify or redistribute this code is prohibited.
Please contact us for more information if required. -->
<div style="width:400px;background:#fff">
  <script type="text/javascript" src="http://magicseaweed.com/syndicate/index.php?licenseKey=1359784508_95420"></script>
   <p>
   <div style="font-family:Arial, Helvetica, sans-serif;text-align:center;font-size:10px;color:#000;height:25px;">
     <a href="http://magicseaweed.com/%s/%s/" style="color:#000;"> %s Surf Report and Forecast </a> </div> </p> </div>'
  end

end
