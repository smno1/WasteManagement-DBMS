require 'test_helper'

class BinAddressesControllerTest < ActionController::TestCase
  setup do
    @bin_address = bin_addresses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bin_addresses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bin_address" do
    assert_difference('BinAddress.count') do
      post :create, bin_address: { address: @bin_address.address, company_id: @bin_address.company_id }
    end

    assert_redirected_to bin_address_path(assigns(:bin_address))
  end

  test "should show bin_address" do
    get :show, id: @bin_address
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bin_address
    assert_response :success
  end

  test "should update bin_address" do
    patch :update, id: @bin_address, bin_address: { address: @bin_address.address, company_id: @bin_address.company_id }
    assert_redirected_to bin_address_path(assigns(:bin_address))
  end

  test "should destroy bin_address" do
    assert_difference('BinAddress.count', -1) do
      delete :destroy, id: @bin_address
    end

    assert_redirected_to bin_addresses_path
  end
end
