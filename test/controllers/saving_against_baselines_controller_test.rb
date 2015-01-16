require 'test_helper'

class SavingAgainstBaselinesControllerTest < ActionController::TestCase
  setup do
    @saving_against_baseline = saving_against_baselines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:saving_against_baselines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create saving_against_baseline" do
    assert_difference('SavingAgainstBaseline.count') do
      post :create, saving_against_baseline: { collection_saved: @saving_against_baseline.collection_saved, month: @saving_against_baseline.month, month_extra_saving: @saving_against_baseline.month_extra_saving, month_saving: @saving_against_baseline.month_saving, note: @saving_against_baseline.note, service: @saving_against_baseline.service }
    end

    assert_redirected_to saving_against_baseline_path(assigns(:saving_against_baseline))
  end

  test "should show saving_against_baseline" do
    get :show, id: @saving_against_baseline
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @saving_against_baseline
    assert_response :success
  end

  test "should update saving_against_baseline" do
    patch :update, id: @saving_against_baseline, saving_against_baseline: { collection_saved: @saving_against_baseline.collection_saved, month: @saving_against_baseline.month, month_extra_saving: @saving_against_baseline.month_extra_saving, month_saving: @saving_against_baseline.month_saving, note: @saving_against_baseline.note, service: @saving_against_baseline.service }
    assert_redirected_to saving_against_baseline_path(assigns(:saving_against_baseline))
  end

  test "should destroy saving_against_baseline" do
    assert_difference('SavingAgainstBaseline.count', -1) do
      delete :destroy, id: @saving_against_baseline
    end

    assert_redirected_to saving_against_baselines_path
  end
end
