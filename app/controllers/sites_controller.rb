class SitesController < ApplicationController
  before_action :set_site, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  # GET /sites
  # GET /sites.json
  def index
    @sites = Site.filter(params.slice(:site_name,:company_id))
    @sites=@sites.order(sort_column+" "+sort_direction).paginate(:per_page=>15,:page=>params[:page])
  end

  # GET /sites/1
  # GET /sites/1.json
  def show
  end

  # GET /sites/new
  def new
    @site = Site.new
    @companies=Company.all
  end

  # GET /sites/1/edit
  def edit
    @companies=Company.all
  end

  # POST /sites
  # POST /sites.json
  def create
    @site = Site.new(site_params)

    respond_to do |format|
      if @site.save
        unless @site.company.nil?
          @site.company.number_of_sites+=1
          @site.company.save
        end
        format.html { redirect_to @site, notice: 'Site was successfully created.' }
        format.json { render :show, status: :created, location: @site }
      else
        format.html { render :new }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sites/1
  # PATCH/PUT /sites/1.json
  def update
    respond_to do |format|
      if @site.update(site_params)
        format.html { redirect_to @site, notice: 'Site was successfully updated.' }
        format.json { render :show, status: :ok, location: @site }
      else
        format.html { render :edit }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site.destroy
    unless @site.company.nil?
      @site.company.number_of_sites-=1
      @site.company.save
    end
    respond_to do |format|
      format.html { redirect_to sites_url, notice: 'Site was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
    def sort_column
      params[:sort] || "site_name"
    end
    
    def sort_direction
      params[:direction] || "asc"
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_site
      @site = Site.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_params
      params.require(:site).permit(:site_name, :site_address, :number_of_service,:company_id)
    end
end
