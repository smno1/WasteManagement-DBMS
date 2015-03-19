class SitesYearlyRecordController < ApplicationController
  before_action :set_site_and_fy, only: [:edit,:update]
  def index
    if is_admin?
      @companies=Company.all
      @sites=Site.all
    else
      @sites=current_user.company.sites
    end
      @column_headers=get_column_headers
  end

  def edit
  end

  def update
    @site.update(params.permit(:monthly_predicted_saving,:program_start_date,:baseline_year,:fy_projected_cost_remainder,:note))
    @site_yearly_record.update(params.permit(:fy_actual_cost,:fy_total_saving))
    redirect_to sites_yearly_records_path
  end
  
  def show_index
    if is_admin?
      @site_yearly_records=SiteYearlyRecord.all
    else
      @site_yearly_records=current_user.company.try(:site_yearly_records)
    end
      @columns=["fy_total_saving","fy_actual_cost","financial_year"]
  end

  def company_select
    if is_admin?
      company=Company.find(params[:company_id])
      @sites=company.sites
    else
      @sites=current_user.company.sites
    end
    @column_headers=get_column_headers
    @inlineJs=true
  end

  private

  def get_column_headers
    fy=DataUtil.get_current_financial_year
    ["centre","region","baseline_costs","predicted_savings","month_savings","%_reduction_on_baseline","payment_to_kumite","program_start_date",
      "annul_baseline_costs","baseline_year","actual_cost_for_#{fy-1}_FY","costs_to_date_#{fy}_FY","project_cost_remainder_#{fy}_FY",
      "projected_FY_#{fy}_total(with no system changes)","annual_predicted_savings","total_savings_#{fy-1}_FY","savings_to_date_#{fy}_FY",
      "total_savings_since_start_program(before_pay_to_kumite)","comments_/_notes"]
  end
  
  def set_site_and_fy
    @site=Site.find(params[:site_id])
    @fy=DataUtil.get_current_financial_year
    @site_yearly_record=SiteYearlyRecord.find_or_create_by(:site_id=>@site.id,:financial_year=>@fy-1)
  end
  #another possible
  #2014.upto(fy) do |year|
  #  @column_headers<<"actual_cost_for_#{year}_FY"
  #end
  #@column_headers+=["costs_to_date_#{fy}_FY","project_cost_remainder_#{fy}_FY",
  #  "projected_FY_#{fy}_total(with no system changes)","annual_predicted_savings"]
  #2014.upto(fy) do |year|
  #  @column_headers<<"total_savings_#{year}_FY"
  #end
  #@column_headers+=["savings_to_date_#{fy}_FY","total_savings_since_start_program(before_pay_to_kumite)","comments_/_notes"]
end
