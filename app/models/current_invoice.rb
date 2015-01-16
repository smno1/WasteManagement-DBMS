class CurrentInvoice < ActiveRecord::Base
  belongs_to :service
    
  after_save do |ci|
    CurrentMonth.update_current_month_data(ci.service_id,ci.Month)
  end
  
  after_destroy do |ci|
    CurrentMonth.update_current_month_data(ci.service_id,ci.Month)
  end
end
