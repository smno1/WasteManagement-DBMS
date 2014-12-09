require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "should get portal" do
    get :portal
    assert_response :success
  end

end
