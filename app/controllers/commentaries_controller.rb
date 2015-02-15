class CommentariesController < ApplicationController
  before_action :set_commentary, only: [:show, :edit, :update, :destroy]
  before_action :check_admin, only: [:new, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  # GET /commentaries
  # GET /commentaries.json
  def index  
    @commentaries = Commentary.filter(filter_params)#where("site_id=#{params[:site_id]}")
    @commentaries=@commentaries.order(sort_column+" "+sort_direction).paginate(:per_page=>15,:page=>params[:page])
  end

  # GET /commentaries/1
  # GET /commentaries/1.json
  def show
  end

  # GET /commentaries/new
  def new
    @commentary = Commentary.new
  end

  # GET /commentaries/1/edit
  def edit
  end

  # POST /commentaries
  # POST /commentaries.json
  def create
    @commentary = Commentary.new(commentary_params)
    respond_to do |format|
      if @commentary.save
        format.html { redirect_to @commentary, notice: 'Commentary was successfully created.' }
        format.json { render :show, status: :created, location: @commentary }
      else
        format.html { render :new }
        format.json { render json: @commentary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /commentaries/1
  # PATCH/PUT /commentaries/1.json
  def update
    respond_to do |format|
      if @commentary.update(commentary_params)
        format.html { redirect_to @commentary, notice: 'Commentary was successfully updated.' }
        format.json { render :show, status: :ok, location: @commentary }
      else
        format.html { render :edit }
        format.json { render json: @commentary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commentaries/1
  # DELETE /commentaries/1.json
  def destroy
    @commentary.destroy
    respond_to do |format|
      format.html { redirect_to commentaries_url, notice: 'Commentary was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def filter_params
      params[:month]= date_select_to_date(params[:month])
      params.slice(:site_id,:month,:comments)
    end
    
    def sort_column
      params[:sort] || "site_id"
    end
    
    def sort_direction
      params[:direction] || "asc"
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_commentary
      @commentary = Commentary.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def commentary_params
      params.require(:commentary).permit(:comments, :month,:site_id)
    end
end
