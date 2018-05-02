require 'test_helper'

class ConsignmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get track" do
    get consignments_track_url
    assert_response :success
  end

end
