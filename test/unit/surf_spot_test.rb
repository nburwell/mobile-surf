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
  end


end
