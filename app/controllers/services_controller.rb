class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  before_action :check_admin, except: [:index]
  helper_method :sort_column, :sort_direction
  # GET /services
  # GET /services.json
  def index
    @services = Service.filter(params.slice(:site_id))
    @column_headers=['client_name','site_name','service_account','description','service_type','recycle','capacity_cubic_meters','target_load',
      'collection_rate','monthly_rental_fee','cost_per_tonne','note','collection_frequency']
    #@services=@services.order(sort_column+" "+sort_direction).paginate(:per_page=>15,:page=>params[:page])
  end

  # GET /services/1
  # GET /services/1.json
  def show
  end

  # GET /services/new
  def new
    @service = Service.new
    @bin_type=CollectionOfSelection.where("selection_type='bin_type'")
    @sites=Site.all
  end

  # GET /services/1/edit
  def edit
    @bin_type=CollectionOfSelection.where("selection_type='bin_type'")
    @sites=Site.all
  end

  # POST /services
  # POST /services.json
  def create
    @service = Service.new(service_params)

    respond_to do |format|
      if @service.save
        unless @service.site.nil?
          @service.site.number_of_service+=1
          @service.site.save
        end
        format.html { redirect_to @service, notice: 'Service was successfully created.' }
        format.json { render :show, status: :created, location: @service }
      else
        format.html { render :new }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to @service, notice: 'Service was successfully updated.' }
        format.json { render :show, status: :ok, location: @service }
      else
        format.html { render :edit }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service.destroy
    unless @service.site.nil?
      @service.site.number_of_service-=1
      @service.site.save
    end
    respond_to do |format|
      format.html { redirect_to services_url, notice: 'Service was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private  
  
    def sort_column
      params[:sort] || "id"
    end
    
    def sort_direction
      params[:direction] || "asc"
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:collection_frequency,:note,:service_type,:monthly_rental_fee,:cost_per_tonne,:account_number_and_name,:description, :is_recycle, :capacity_cubic_meters, :target_load, :collection_rate, :density_of_waste, :year_installed, :site_id)
    end
end
