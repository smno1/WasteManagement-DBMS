class SavingAgainstBaselinesController < ApplicationController
  before_action :set_saving_against_baseline, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @saving_against_baselines = SavingAgainstBaseline.where("service_id=?", params[:service_id])
    respond_with(@saving_against_baselines)
  end

  def show
  @baseline_data=BaselineData.find_by :service_id=>@saving_against_baseline.service_id
  @current_month=CurrentMonth.find_by :service_id=>@saving_against_baseline.service_id,
          :Month=>@saving_against_baseline.month
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
    @saving_against_baseline.service_id=params[:service_id]
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
    puts @saving_against_baseline.to_yaml
    @saving_against_baseline = SavingAgainstBaseline.update_sab_data(@saving_against_baseline)
    puts @saving_against_baseline.to_yaml
    if @saving_against_baseline.nil?
      redirect_to new_saving_against_baseline_path, :flash=> {:error => "Don't have current month invoice for selected month"}
      return
    end
    @saving_against_baseline.save
    respond_with(@saving_against_baseline)
  end

  def destroy
    @saving_against_baseline.destroy
    respond_with(@saving_against_baseline)
  end

  private
    def set_saving_against_baseline
      @saving_against_baseline = SavingAgainstBaseline.find(params[:id])
    end

    def saving_against_baseline_params
      params.require(:saving_against_baseline).permit(:service_id, :month, :collection_saved, :month_saving, :month_extra_saving, :note)
    end
end
