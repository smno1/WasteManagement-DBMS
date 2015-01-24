class BaselineInvoice < ActiveRecord::Base
  include Filterable
  belongs_to :service
  
  scope :service_id, ->(service_id){where service_id:service_id}
  scope :Month, ->(month){where Month:month}
  scope :collection_date, ->(from_date,to_date){where :collection_date=> from_date..to_date}
  
  after_save do |bi|
    puts "update baseline data"
    BaselineDatum.update_service_baseline_data(bi.service_id)
  end
  
  after_destroy do |bi| 
    puts "update baseline data"
    BaselineDatum.update_service_baseline_data(bi.service_id)
  end
end
