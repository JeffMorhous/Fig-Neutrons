require 'test_helper'

class InstructorControllerTest < ActionDispatch::IntegrationTest
  test "should get signup" do
    get instructor_signup_url
    assert_response :success
  end

end
