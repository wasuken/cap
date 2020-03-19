require 'test_helper'

class Api::V1::NetPacketsControllerTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers
  test "get api root" do
    @user = users(:one)
    login_as(@user, scope: :user)
    get "/api/v1/net_packets?token=#{@user.token}"
    assert_response :success
  end
end
