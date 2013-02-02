require 'test_helper'

class SurfSpotTest < ActiveSupport::TestCase

  context 'with a user' do
    should "be able to construct a surf_spot" do
      sp = SurfSpot.new(
        :lat=> "100.00",
        :long => "100.00",
        :name => "zuma",
        :msw_id => 100,
        :msw_name => "zuma-surf-report"
      )

      assert sp
      assert_equal "100.00",           sp.lat
      assert_equal "100.00",           sp.long
      assert_equal "zuma",             sp.name
      assert_equal 100,                sp.msw_id
      assert_equal "zuma-surf-report", sp.msw_name
    end

    should "be able to generate the widget url" do
      sp = SurfSpot.new(
        :lat=> "100.00",
        :long => "100.00",
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
  end


end
