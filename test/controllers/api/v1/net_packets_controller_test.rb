require 'test_helper'

class Api::V1::NetPacketsControllerTest < ActionDispatch::IntegrationTest
  test "get api root" do
    get "/api/v1/net_packets"
    assert_response :success
  end
end
