class BaselineInvoicesController < ApplicationController
  before_action :set_baseline_invoice, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @baseline_invoices = BaselineInvoice.where("service_id=#{params[:service_id]}")
    respond_with(@baseline_invoices)
  end

  def show
    respond_with(@baseline_invoice)
  end

  def new
    @baseline_invoice = BaselineInvoice.new
    #@services=Service.all
    respond_with(@baseline_invoice)
  end

  def edit
    #@services=Service.all
  end

  def create
    @baseline_invoice = BaselineInvoice.new(baseline_invoice_params)
    @baseline_invoice.collection_day=@baseline_invoice.collection_date.strftime("%A")
    @baseline_invoice.service_id=params[:service_id]
    @baseline_invoice.save
    BaselineData.update_service_baseline_data(@baseline_invoice.service_id)
    redirect_to baseline_invoices_path(:service_id=>params[:service_id])
  end

  def update
    @baseline_invoice.update(baseline_invoice_params)
    @baseline_invoice.collection_day=@baseline_invoice.collection_date.strftime("%A")
    BaselineData.update_service_baseline_data(@baseline_invoice.service_id)
    redirect_to baseline_invoices_path(:service_id=>params[:service_id])
  end

  def destroy
    sid=@baseline_invoice.service_id
    @baseline_invoice.destroy
    BaselineData.update_service_baseline_data(sid)
    redirect_to baseline_invoices_path(:service_id=>sid)
  end

  private
    def set_baseline_invoice
      @baseline_invoice = BaselineInvoice.find(params[:id])
    end

    def baseline_invoice_params
      params.require(:baseline_invoice).permit(:service_id, :Month, :collection_date, :collection_day, :tonnes)
    end
end
