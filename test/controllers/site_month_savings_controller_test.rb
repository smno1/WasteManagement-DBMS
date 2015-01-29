require 'test_helper'

class SiteMonthSavingsControllerTest < ActionController::TestCase
  setup do
    @site_month_saving = site_month_savings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:site_month_savings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create site_month_saving" do
    assert_difference('SiteMonthSaving.count') do
      post :create, site_month_saving: { month: @site_month_saving.month, month_saving: @site_month_saving.month_saving, recycling_rate: @site_month_saving.recycling_rate, site_id: @site_month_saving.site_id }
    end

    assert_redirected_to site_month_saving_path(assigns(:site_month_saving))
  end

  test "should show site_month_saving" do
    get :show, id: @site_month_saving
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @site_month_saving
    assert_response :success
  end

  test "should update site_month_saving" do
    patch :update, id: @site_month_saving, site_month_saving: { month: @site_month_saving.month, month_saving: @site_month_saving.month_saving, recycling_rate: @site_month_saving.recycling_rate, site_id: @site_month_saving.site_id }
    assert_redirected_to site_month_saving_path(assigns(:site_month_saving))
  end

  test "should destroy site_month_saving" do
    assert_difference('SiteMonthSaving.count', -1) do
      delete :destroy, id: @site_month_saving
    end

    assert_redirected_to site_month_savings_path
  end
end
