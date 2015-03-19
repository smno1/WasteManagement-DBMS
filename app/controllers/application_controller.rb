class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  helper_method :date_select_to_date
  helper_method :is_admin?
  
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound do
    flash[:warning] = 'Resource not found.'
    redirect_back_or welcome_portal_path
  end
 
  def redirect_back_or(path)
    redirect_to request.referer || path
  end
    
  def update_sites
    _company=Company.find(params[:company_id])
    @sites=_company.sites.map{|s| [s.site_name, s.id]}
  end
  
  def check_admin
    unless is_admin?
      redirect_to welcome_portal_path, :flash=> {:error => "Sorry, only admin can access"}
    end
  end
  def is_admin?
    return current_user.present? && current_user.has_role?(:admin)
  end
  def date_select_to_date (date_hash,default_month="1")
    return date_hash unless date_hash.is_a? Hash
    return nil if date_hash.blank?
    return nil if date_hash["date(1i)"].blank?
    date_hash["date(2i)"]=date_hash["date(2i)"].blank? ? default_month : date_hash["date(2i)"]
    Date.new date_hash["date(1i)"].to_i, date_hash["date(2i)"].to_i, date_hash["date(3i)"].to_i
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:user_name, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:user_name, :password, :password_confirmation, :current_password) }
  end
private

   def after_sign_in_path_for(resource)
     welcome_portal_path
   end
   def after_sign_out_path_for(resource_or_scope)
     new_user_session_path
   end
end
