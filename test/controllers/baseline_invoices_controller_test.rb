require 'test_helper'

class BaselineInvoicesControllerTest < ActionController::TestCase
  setup do
    @baseline_invoice = baseline_invoices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:baseline_invoices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create baseline_invoice" do
    assert_difference('BaselineInvoice.count') do
      post :create, baseline_invoice: { Month: @baseline_invoice.Month, collection_date: @baseline_invoice.collection_date, collection_day: @baseline_invoice.collection_day, service_id: @baseline_invoice.service_id, tonnes: @baseline_invoice.tonnes }
    end

    assert_redirected_to baseline_invoice_path(assigns(:baseline_invoice))
  end

  test "should show baseline_invoice" do
    get :show, id: @baseline_invoice
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @baseline_invoice
    assert_response :success
  end

  test "should update baseline_invoice" do
    patch :update, id: @baseline_invoice, baseline_invoice: { Month: @baseline_invoice.Month, collection_date: @baseline_invoice.collection_date, collection_day: @baseline_invoice.collection_day, service_id: @baseline_invoice.service_id, tonnes: @baseline_invoice.tonnes }
    assert_redirected_to baseline_invoice_path(assigns(:baseline_invoice))
  end

  test "should destroy baseline_invoice" do
    assert_difference('BaselineInvoice.count', -1) do
      delete :destroy, id: @baseline_invoice
    end

    assert_redirected_to baseline_invoices_path
  end
end
