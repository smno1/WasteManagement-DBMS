class CurrentInvoicesController < ApplicationController
  before_action :set_current_invoice, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @current_invoices = CurrentInvoice.where("service_id=#{params[:service_id]}")
    respond_with(@current_invoices)
  end

  def show
    respond_with(@current_invoice)
  end

  def new
    @current_invoice = CurrentInvoice.new
    respond_with(@current_invoice)
  end

  def edit
  end

  def create
    @current_invoice = CurrentInvoice.new(current_invoice_params)
    @current_invoice.collection_day=@current_invoice.collection_date.strftime("%A")
    @current_invoice.service_id=params[:service_id]
    @current_invoice.save
    CurrentMonth.update_current_month_data(@current_invoice.service_id,@current_invoice.Month)
    redirect_to current_invoices_path(:service_id=>params[:service_id])
  end

  def update
    @current_invoice.update(current_invoice_params)
    @current_invoice.collection_day=@current_invoice.collection_date.strftime("%A")
    CurrentMonth.update_current_month_data(@current_invoice.service_id,@current_invoice.Month)
    redirect_to current_invoices_path(:service_id=>params[:service_id])
  end

  def destroy
    sid=@current_invoice.service_id
    month=@current_invoice.Month
    @current_invoice.destroy
    CurrentMonth.update_current_month_data(sid,month)
    redirect_to current_invoices_path(:service_id=>sid)
  end

  private
    def set_current_invoice
      @current_invoice = CurrentInvoice.find(params[:id])
    end

    def current_invoice_params
      params.require(:current_invoice).permit(:Month, :collection_date, :collection_day, :tonnes, :service_id)
    end
end
