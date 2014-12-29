require 'test_helper'

class ServicesControllerTest < ActionController::TestCase
  setup do
    @service = services(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:services)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create service" do
    assert_difference('Service.count') do
      post :create, service: { bin_type: @service.bin_type, capacity_cubic_meters: @service.capacity_cubic_meters, density_of_waste: @service.density_of_waste, highest_actual_load: @service.highest_actual_load, is_recycle: @service.is_recycle, max_load: @service.max_load, site_id: @service.site_id }
    end

    assert_redirected_to service_path(assigns(:service))
  end

  test "should show service" do
    get :show, id: @service
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @service
    assert_response :success
  end

  test "should update service" do
    patch :update, id: @service, service: { bin_type: @service.bin_type, capacity_cubic_meters: @service.capacity_cubic_meters, density_of_waste: @service.density_of_waste, highest_actual_load: @service.highest_actual_load, is_recycle: @service.is_recycle, max_load: @service.max_load, site_id: @service.site_id }
    assert_redirected_to service_path(assigns(:service))
  end

  test "should destroy service" do
    assert_difference('Service.count', -1) do
      delete :destroy, id: @service
    end

    assert_redirected_to services_path
  end
end
