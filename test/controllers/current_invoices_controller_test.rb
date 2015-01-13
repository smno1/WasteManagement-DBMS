require 'test_helper'

class CurrentInvoicesControllerTest < ActionController::TestCase
  setup do
    @current_invoice = current_invoices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:current_invoices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create current_invoice" do
    assert_difference('CurrentInvoice.count') do
      post :create, current_invoice: { Month: @current_invoice.Month, collection_date: @current_invoice.collection_date, collection_day: @current_invoice.collection_day, service_id: @current_invoice.service_id, tonnes: @current_invoice.tonnes }
    end

    assert_redirected_to current_invoice_path(assigns(:current_invoice))
  end

  test "should show current_invoice" do
    get :show, id: @current_invoice
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @current_invoice
    assert_response :success
  end

  test "should update current_invoice" do
    patch :update, id: @current_invoice, current_invoice: { Month: @current_invoice.Month, collection_date: @current_invoice.collection_date, collection_day: @current_invoice.collection_day, service_id: @current_invoice.service_id, tonnes: @current_invoice.tonnes }
    assert_redirected_to current_invoice_path(assigns(:current_invoice))
  end

  test "should destroy current_invoice" do
    assert_difference('CurrentInvoice.count', -1) do
      delete :destroy, id: @current_invoice
    end

    assert_redirected_to current_invoices_path
  end
end
