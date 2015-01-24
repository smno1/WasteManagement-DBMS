class CurrentInvoicesController < ApplicationController
  before_action :set_current_invoice, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  respond_to :html

  def index
    @current_invoices = CurrentInvoice.where("service_id=#{params[:service_id]}")
    @current_invoices=@current_invoices.order(sort_column+" "+sort_direction).paginate(:per_page=>15,:page=>params[:page])
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
    @current_invoice.save
    redirect_to current_invoices_path(:service_id=>@current_invoice.service_id)
  end

  def update
    @current_invoice.update(current_invoice_params)
    @current_invoice.collection_day=@current_invoice.collection_date.strftime("%A")
    @current_invoice.save
    redirect_to current_invoices_path(:service_id=>@current_invoice.service_id)
  end

  def destroy
    sid=@current_invoice.service_id
    @current_invoice.destroy
    redirect_to current_invoices_path(:service_id=>sid)
  end

  private
    
    def sort_column
      params[:sort] || "id"
    end
      
    def sort_direction
      params[:direction] || "asc"
    end
    
    def set_current_invoice
      @current_invoice = CurrentInvoice.find(params[:id])
    end

    def current_invoice_params
      params.require(:current_invoice).permit(:Month, :collection_date, :collection_day, :tonnes, :service_id)
    end
end
