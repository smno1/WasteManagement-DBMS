class BaselineDataController < ApplicationController
  before_action :set_baseline_datum, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @baseline_data = BaselineDatum.filter(params.slice(:service_id)).paginate(:per_page=>15,:page=>params[:page])
    respond_with(@baseline_data)
  end

  def show
    respond_with(@baseline_datum)
  end

  def new
    @baseline_datum = BaselineDatum.new
    respond_with(@baseline_datum)
  end

  def edit
  end

  def create
    @baseline_datum = BaselineDatum.new(baseline_datum_params)
    @baseline_datum.monthly_charge=@baseline_datum.monthly_collection*@baseline_datum.service.collection_rate
    @baseline_datum.save
    respond_with(@baseline_datum)
  end

  def update
    @baseline_datum.update(baseline_datum_params)
    respond_with(@baseline_datum)
  end

  def destroy
    @baseline_datum.destroy
    redirect_to services_path
  end

  private
    def set_baseline_datum
      @baseline_datum = BaselineDatum.find(params[:id])
    end

    def baseline_datum_params
      params.require(:baseline_datum).permit(:monthly_collection, :monthly_charge, :service_id)
    end
end
