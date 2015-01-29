class SiteMonthSavingsController < ApplicationController
  before_action :set_site_month_saving, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @site_month_savings = SiteMonthSaving.all
    respond_with(@site_month_savings)
  end

  def show
    respond_with(@site_month_saving)
  end

  def new
    @site_month_saving = SiteMonthSaving.new
    respond_with(@site_month_saving)
  end

  def edit
  end

  def create
    @site_month_saving = SiteMonthSaving.new(site_month_saving_params)
    @site_month_saving.save
    respond_with(@site_month_saving)
  end

  def update
    @site_month_saving.update(site_month_saving_params)
    respond_with(@site_month_saving)
  end

  def destroy
    @site_month_saving.destroy
    respond_with(@site_month_saving)
  end

  private
    def set_site_month_saving
      @site_month_saving = SiteMonthSaving.find(params[:id])
    end

    def site_month_saving_params
      params.require(:site_month_saving).permit(:site_id, :month, :month_saving, :recycling_rate)
    end
end
