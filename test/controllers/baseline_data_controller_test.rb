require 'test_helper'

class BaselineDataControllerTest < ActionController::TestCase
  setup do
    @baseline_datum = baseline_data(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:baseline_data)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create baseline_datum" do
    assert_difference('BaselineDatum.count') do
      post :create, baseline_datum: { monthly_charge: @baseline_datum.monthly_charge, monthly_collection: @baseline_datum.monthly_collection, service_id: @baseline_datum.service_id }
    end

    assert_redirected_to baseline_datum_path(assigns(:baseline_datum))
  end

  test "should show baseline_datum" do
    get :show, id: @baseline_datum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @baseline_datum
    assert_response :success
  end

  test "should update baseline_datum" do
    patch :update, id: @baseline_datum, baseline_datum: { monthly_charge: @baseline_datum.monthly_charge, monthly_collection: @baseline_datum.monthly_collection, service_id: @baseline_datum.service_id }
    assert_redirected_to baseline_datum_path(assigns(:baseline_datum))
  end

  test "should destroy baseline_datum" do
    assert_difference('BaselineDatum.count', -1) do
      delete :destroy, id: @baseline_datum
    end

    assert_redirected_to baseline_data_path
  end
end
