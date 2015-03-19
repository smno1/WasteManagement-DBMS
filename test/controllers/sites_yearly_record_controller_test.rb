require 'test_helper'

class SitesYearlyRecordControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get company_select" do
    get :company_select
    assert_response :success
  end

end
