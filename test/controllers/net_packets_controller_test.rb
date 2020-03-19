require 'test_helper'

class NetPacketsControllerTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers
  test "get login page" do
    @user = users(:one)
    login_as(@user, scope: :user)
    get "/"
    assert_select "h2", "index"
    assert_response :success
  end
end
