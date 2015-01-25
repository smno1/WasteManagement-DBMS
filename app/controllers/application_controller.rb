class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def date_select_to_date (date_hash)
    return date_hash unless date_hash.is_a? Hash
    return nil if date_hash.blank?
    date_hash.each do |k,v|
      return nil if v.blank?
    end
    Date.new date_hash["date(1i)"].to_i, date_hash["date(2i)"].to_i, date_hash["date(3i)"].to_i
  end
  
end
