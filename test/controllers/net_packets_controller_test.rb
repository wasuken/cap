require 'test_helper'

class NetPacketsControllerTest < ActionDispatch::IntegrationTest
  test "get root" do
    get "/"
    assert_select "h2", "index"
    assert_response :success
  end
  test "get api root" do
    get "/api/v1/net_packets"
    assert_response :success
  end
end
