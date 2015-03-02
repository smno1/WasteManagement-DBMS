class UserManagementController < ApplicationController
  before_action :check_admin
  before_action :set_user, only: [:edit, :destroy,:update]
  helper_method :sort_column, :sort_direction

  def index
    @users=User.all
    #filter(params.slice(:email,:user_name))
    #@users=@users.order(sort_column+" "+sort_direction).paginate(:per_page=>15,:page=>params[:page])
  end

  def edit
    @companies=Company.all
  end
  
  def update
    params[:company_id]=0 if params[:company_id].blank?
    @user.update(params.permit(:email,:user_name,:company_id,:note))
    redirect_to user_management_path
  end

  def send_email
  end
  
  def destroy
    @user.destroy
    redirect_to user_management_path
  end
  
  private
    def set_user
      @user = User.find(params[:user_id])
    end
  
    def sort_column
      params[:sort] || "id"
    end
    
    def sort_direction
      params[:direction] || "asc"
    end
    
end
