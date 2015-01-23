class CurrentMonthsController < ApplicationController
  before_action :set_current_month, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @current_months = CurrentMonth.all
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
    @current_month.save
    respond_with(@current_month)
  end

  def update
    @current_month.update(current_month_params)
    respond_with(@current_month)
  end

  def destroy
    @current_month.destroy
    respond_with(@current_month)
  end

  private
    def set_current_month
      @current_month = CurrentMonth.find(params[:id])
    end

    def current_month_params
      params.require(:current_month).permit(:month_total_tonnes, :month_average_load, :actual_month_collection, :actual_month_charge, :optimal_collection, :days_interval, :Month, :service_id)
    end
end
