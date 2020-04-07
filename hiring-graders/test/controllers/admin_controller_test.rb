require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get signup" do
    get admin_signup_url
    assert_response :success
  end

end
