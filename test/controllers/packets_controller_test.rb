require 'test_helper'

class PacketsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get packets_index_url
    assert_response :success
  end

end
