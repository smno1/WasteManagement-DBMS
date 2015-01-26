class SavingAgainstBaselinesController < ApplicationController
  before_action :set_saving_against_baseline, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  respond_to :html

  def index
#    @sites=Site.all
#    unless(params[:site_id].blanck)
      
#    end
    @saving_against_baselines = SavingAgainstBaseline.filter(filter_params)
    @saving_against_baselines=@saving_against_baselines.order(sort_column+" "+sort_direction).paginate(:per_page=>15,:page=>params[:page])
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
      redirect_to new_saving_against_baseline_path, :flash=> {:error => "Don't have current month invoice for selected month"}
      return
    end
    @saving_against_baseline.save
    respond_with(@saving_against_baseline)
  end

  def update
    @saving_against_baseline.update(saving_against_baseline_params)
    @saving_against_baseline = SavingAgainstBaseline.update_sab_data(@saving_against_baseline)
    if @saving_against_baseline.nil?
      redirect_to saving_against_baselines_path, :flash=> {:error => "Don't have current month invoice for selected month"}
      return
    end
    @saving_against_baseline.save
    respond_with(@saving_against_baseline)
  end

  def destroy
    sid=@saving_against_baseline.service_id
    @saving_against_baseline.destroy
    redirect_to saving_against_baselines_path(:service_id=>sid)
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
      params.require(:saving_against_baseline).permit(:service_id, :month, :collection_saved, :month_saving, :month_extra_saving, :note)
    end
end
