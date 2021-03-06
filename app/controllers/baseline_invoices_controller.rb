class BaselineInvoicesController < ApplicationController
  before_action :set_baseline_invoice, only: [:show, :edit, :update, :destroy]
  before_action :check_admin, only: [:new, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  respond_to :html

  def index
    @baseline_invoices = BaselineInvoice.filter(filter_params)
    from_date=date_select_to_date(params[:collection_date_from])
    to_date=date_select_to_date(params[:collection_date_to]).try(:+,1.month).try(:-,1.day)
    @baseline_invoices=@baseline_invoices.collection_date(from_date,to_date) unless (from_date.nil? ||to_date.nil?)
    @baseline_invoices=@baseline_invoices.order(sort_column+" "+sort_direction).paginate(:per_page=>15,:page=>params[:page])
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
    @baseline_invoice.save
    redirect_to baseline_invoices_path(:service_id=>@baseline_invoice.service_id)
  end

  def update
    @baseline_invoice.update(baseline_invoice_params)
    @baseline_invoice.collection_day=@baseline_invoice.collection_date.strftime("%A")
    @baseline_invoice.save
    redirect_to baseline_invoices_path(:service_id=>@baseline_invoice.service_id)
  end

  def destroy
    sid=@baseline_invoice.service_id
    @baseline_invoice.destroy
    redirect_to baseline_invoices_path(:service_id=>sid)
  end

  private
    
    def filter_params
      params[:month]= date_select_to_date(params[:month])
      #params[:month]["date(1i)"].blank? || params[:month]["date(2i)"].blank? ? 
       #                 nil : date_select_to_date(params[:month]) unless params[:month].nil?
      params.slice(:service_id,:month)
    end
    
    def sort_column
      params[:sort] || "id"
    end
      
    def sort_direction
      params[:direction] || "asc"
    end

    def set_baseline_invoice
      @baseline_invoice = BaselineInvoice.find(params[:id])
    end

    def baseline_invoice_params
      params.require(:baseline_invoice).permit(:service_id, :month, :collection_date, :collection_day, :tonnes)
    end
end
