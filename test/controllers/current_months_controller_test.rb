require 'test_helper'

class CurrentMonthsControllerTest < ActionController::TestCase
  setup do
    @current_month = current_months(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:current_months)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create current_month" do
    assert_difference('CurrentMonth.count') do
      post :create, current_month: { Month: @current_month.Month, actual_month_charge: @current_month.actual_month_charge, actual_month_collection: @current_month.actual_month_collection, days_interval: @current_month.days_interval, month_average_load: @current_month.month_average_load, month_total_tonnes: @current_month.month_total_tonnes, optimal_collection: @current_month.optimal_collection, service_id: @current_month.service_id }
    end

    assert_redirected_to current_month_path(assigns(:current_month))
  end

  test "should show current_month" do
    get :show, id: @current_month
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @current_month
    assert_response :success
  end

  test "should update current_month" do
    patch :update, id: @current_month, current_month: { Month: @current_month.Month, actual_month_charge: @current_month.actual_month_charge, actual_month_collection: @current_month.actual_month_collection, days_interval: @current_month.days_interval, month_average_load: @current_month.month_average_load, month_total_tonnes: @current_month.month_total_tonnes, optimal_collection: @current_month.optimal_collection, service_id: @current_month.service_id }
    assert_redirected_to current_month_path(assigns(:current_month))
  end

  test "should destroy current_month" do
    assert_difference('CurrentMonth.count', -1) do
      delete :destroy, id: @current_month
    end

    assert_redirected_to current_months_path
  end
end
