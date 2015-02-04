require 'test_helper'

class PrintableControllerTest < ActionController::TestCase
  test "should get site_month_invoice" do
    get :site_month_invoice
    assert_response :success
  end

end
