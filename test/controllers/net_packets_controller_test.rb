require 'test_helper'

class NetPacketsControllerTest < ActionDispatch::IntegrationTest
  test "get root" do
    get "/"
    assert_select "h2", "index"
    assert_response :success
  end
end
