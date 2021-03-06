class BaselineInvoice < ActiveRecord::Base
  include Filterable
  belongs_to :service
  
  scope :service_id, ->(service_id){where service_id:service_id}
  scope :month, ->(month){where month:month}
  scope :collection_date, ->(from_date,to_date){where :collection_date=> from_date..to_date}
  
  after_save do |bi|
    BaselineDatum.update_service_baseline_data(bi.service_id)
  end
  
  after_destroy do |bi| 
    BaselineDatum.update_service_baseline_data(bi.service_id)
  end
end
