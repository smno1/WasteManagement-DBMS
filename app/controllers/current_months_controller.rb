class CurrentMonthsController < ApplicationController
  before_action :set_current_month, only: [:show, :edit, :update, :destroy]
  before_action :check_admin

  respond_to :html

  def index
    @current_months = CurrentMonth.filter(params.slice(:service_id)).paginate(:per_page=>15,:page=>params[:page])
    respond_with(@current_months)
  end

  def show
    respond_with(@current_month)
  end

  def new
    @current_month = CurrentMonth.new
    respond_with(@current_month)
  end

  def edit
  end

  def create
    @current_month = CurrentMonth.new(current_month_params)
    @current_month.complete_attribute
    @current_month.save
    redirect_to current_months_path(:service_id=>@current_month.service_id)
  end

  def update
    @current_month.update(current_month_params)
    @current_month.complete_attribute
    @current_month.save
    redirect_to current_months_path(:service_id=>@current_month.service_id)
  end

  def destroy
    sid=@current_month.service_id
    @current_month.destroy
    redirect_to current_months_path(:service_id=>sid)
  end

  private
  
    def set_current_month
      @current_month = CurrentMonth.find(params[:id])
    end

    def current_month_params
      params.require(:current_month).permit(:month_average_load, :actual_month_collection, :month, :service_id)
    end
end
