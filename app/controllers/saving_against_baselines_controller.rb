class SavingAgainstBaselinesController < ApplicationController
  before_action :set_saving_against_baseline, only: [:show, :edit, :update, :destroy]
  before_action :check_admin, except: [:index]
  helper_method :sort_column, :sort_direction
  respond_to :html

  def index
    @column_header=['month','client_name','site_name','service_account','service_type','service_description','collecation_saved',
    'month_saving','month_extra_saving','month_excluded_cost','month_total_saving','note']
    @companies=Company.all
    @sites=Site.none if @sites.blank?
    @saving_against_baselines = SavingAgainstBaseline.filter(filter_params)
    if(params[:site_id].present?)
      site=Site.find(params[:site_id])
      @saving_against_baselines=params[:month].blank? ? site.saving_against_baselines : site.saving_against_baselines.month(params[:month])
    elsif(params[:company_id].present?)
      company=Company.find(params[:company_id])
      @saving_against_baselines=params[:month].blank? ? company.saving_against_baselines : company.saving_against_baselines.month(params[:month])
    end
    #@saving_against_baselines=@saving_against_baselines.order(sort_column+" "+sort_direction).paginate(:per_page=>15,:page=>params[:page])
    respond_with(@saving_against_baselines)
  end

  def show
  @baseline_data=BaselineDatum.find_by :service_id=>@saving_against_baseline.service_id
  @current_month=CurrentMonth.find_by :service_id=>@saving_against_baseline.service_id,
          :month=>@saving_against_baseline.month
    respond_with(@saving_against_baseline)
  end

  def new
    @saving_against_baseline = SavingAgainstBaseline.new
    respond_with(@saving_against_baseline)
  end

  def edit
  end

  def create
    @saving_against_baseline = SavingAgainstBaseline.new(saving_against_baseline_params)
    @saving_against_baseline = SavingAgainstBaseline.update_sab_data(@saving_against_baseline)
    if @saving_against_baseline.nil?
      redirect_to new_saving_against_baseline_path, :flash=> {:warning => "Don't have current summary or baseline summary for selected month"}
      return
    end
    @saving_against_baseline.save
    respond_with(@saving_against_baseline)
  end

  def update
    @saving_against_baseline.update(saving_against_baseline_params)
    @saving_against_baseline = SavingAgainstBaseline.update_sab_data(@saving_against_baseline)
    if @saving_against_baseline.nil?
      redirect_to saving_against_baselines_path, :flash=> {:warning => "Don't have current summary or baseline summary for selected month"}
      return
    end
    @saving_against_baseline.save
    respond_with(@saving_against_baseline)
  end

  def destroy
    @saving_against_baseline.destroy
    redirect_to saving_against_baselines_path
  end

  private
  
    def filter_params
      params[:month]= date_select_to_date(params[:month])
      params.slice(:service_id,:month)
    end
    
    def sort_column
      params[:sort] || "id"
    end
      
    def sort_direction
      params[:direction] || "asc"
    end
    
    def set_saving_against_baseline
      @saving_against_baseline = SavingAgainstBaseline.find(params[:id])
    end

    def saving_against_baseline_params
      params.require(:saving_against_baseline).permit(:service_id, :month_excluded_cost, :month_total_saving, :month, :collection_saved, :month_saving, :month_extra_saving, :note)
    end
end
