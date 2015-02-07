class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def update_sites
    _company=Company.find(params[:company_id])
    @sites=_company.sites.map{|s| [s.site_name, s.id]}
  end
  
  def date_select_to_date (date_hash,default_month="1")
    return date_hash unless date_hash.is_a? Hash
    return nil if date_hash.blank?
    return nil if date_hash["date(1i)"].blank?
    date_hash["date(2i)"]=date_hash["date(2i)"].blank? ? default_month : date_hash["date(2i)"]
    Date.new date_hash["date(1i)"].to_i, date_hash["date(2i)"].to_i, date_hash["date(3i)"].to_i
  end
  
end
