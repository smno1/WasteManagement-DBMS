class BaselineInvoice < ActiveRecord::Base
  belongs_to :service
  
  after_save do |bi|
    puts "update baseline data"
    BaselineDatum.update_service_baseline_data(bi.service_id)
  end
  
  after_destroy do |bi| 
    puts "update baseline data"
    BaselineDatum.update_service_baseline_data(bi.service_id)
  end
end
