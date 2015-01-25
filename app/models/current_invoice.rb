class CurrentInvoice < ActiveRecord::Base
  include Filterable
  belongs_to :service
    
  scope :service_id, ->(service_id){where service_id:service_id}
  scope :Month, ->(month){where Month:month}
  scope :collection_date, ->(from_date,to_date){where :collection_date=> from_date..to_date}
    
  after_save do |ci|
    CurrentMonth.update_current_month_data(ci.service_id,ci.Month)
  end
  
  after_destroy do |ci|
    CurrentMonth.update_current_month_data(ci.service_id,ci.Month)
  end
end
