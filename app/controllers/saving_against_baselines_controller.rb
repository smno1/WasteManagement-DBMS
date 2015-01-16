class SavingAgainstBaselinesController < ApplicationController
  before_action :set_saving_against_baseline, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @saving_against_baselines = SavingAgainstBaseline.all
    respond_with(@saving_against_baselines)
  end

  def show
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
    @saving_against_baseline.save
    respond_with(@saving_against_baseline)
  end

  def update
    @saving_against_baseline.update(saving_against_baseline_params)
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
      params.require(:saving_against_baseline).permit(:service, :month, :collection_saved, :month_saving, :month_extra_saving, :note)
    end
end
