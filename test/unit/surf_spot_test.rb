require 'test_helper'

class SurfSpotTest < ActiveSupport::TestCase

  context 'with a user' do
    should "be able to construct a surf_spot" do
      sp = SurfSpot.new(
        :latitude => 100.00,
        :longitude => 100.00,
        :name => "zuma",
        :msw_id => 100,
        :msw_name => "zuma-surf-report"
      )

      assert sp
      assert_equal 100.00,           sp.latitude
      assert_equal 100.00,           sp.longitude
      assert_equal "zuma",             sp.name
      assert_equal 100,                sp.msw_id
      assert_equal "zuma-surf-report", sp.msw_name
    end

    should "be able to generate the widget url" do
      sp = SurfSpot.new(
        :latitude => 100.00,
        :longitude => 100.00,
        :name => "California Street (C Street)",
        :msw_id => 275,
        :msw_name => "California-Street-C-Street-Surf-Report"
      )


      expected = '
        <!-- This code is issued by Magicseaweed.com under license 1359784508_95420 for the website  only subject to terms and conditions
        and this message being kept intact as part of the code. If you are not the license holder add this content to your website by registering at
        Magicseaweed.com. All copyrights retained by Metcentral Ltd and any attempt to modify or redistribute this code is prohibited.
        Please contact us for more information if required. -->
        <div style="width:400px;background:#fff">
        <script type="text/javascript" src="http://magicseaweed.com/syndicate/index.php?licenseKey=1359784508_95420"></script>
        <p>
        <div style="font-family:Arial, Helvetica, sans-serif;text-align:center;font-size:10px;color:#000;height:25px;">
        <a href="http://magicseaweed.com/California-Street-C-Street-Surf-Report/275/" style="color:#000;">
        California Street (C Street) Surf Report and Forecast
        </a>
        </div>
        </p>
        </div>'

      assert_equal expected.squish, sp.msw_widget_embed.squish
    end

    should "support point arena" do
      sp = SurfSpot.create!(
        :latitude => 38.908798,
        :longitude => -123.693726,
        :name => "Point Arena",
        :msw_id => 304,
        :msw_name => "Point-Arena-Surf-Report"
      )
      assert_equal "25-101 Port Road, Point Arena, CA 95468, USA", sp.address

      assert_equal 412, sp.distance_to("93010").to_i
      assert_equal 412, sp.distance_to([ 34.2330908, -119.0809012]).to_i
    end

    should "find nearest" do
      SurfSpot.create!(
        :latitude => 38.908798,
        :longitude => -123.693726,
        :name => "Point Arena",
        :msw_id => 304,
        :msw_name => "Point-Arena-Surf-Report"
      )

      SurfSpot.create!(
        :latitude => 34.2330908,
        :longitude => -119.0809012,
        :name => "sb",
        :msw_id => 304,
        :msw_name => "Point-Arena-Surf-Report"
      )

      assert_equal ["sb"], SurfSpot.near([ 34.2330908, -119.100],20).map{|ss| ss.name}
      assert_equal ["sb", "Point Arena"], SurfSpot.near([ 34.2330908, -119.100],500).map{|ss| ss.name}

    end
  end


end
