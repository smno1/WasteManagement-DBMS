class BaselineDatum < ActiveRecord::Base
  include Filterable
  
  scope :service_id, ->(id){where service_id:id}
  
  belongs_to :service
  def self.recalculate_baseline_data
    baseline_invoices=BaselineInvoice.all
    service_grouped_invoices=baseline_invoices.group('service_id')
    service_grouped_invoices.each do |s_g_i|
      self.update_service_baseline_data(s_g_i.service_id)
    end
  end

  def self.update_service_baseline_data(sid)
    service_baseline=self.find_or_initialize_by(service_id: sid)#self.where("service_id=#{sid}")
    service_baseline.update(self.baseline_data_params(sid))
    #service_baseline.delete_all unless service_baseline.blank?
    #self.create_service_baseline_data(sid)
  end
 
  private
 
  def self.baseline_data_params(sid)
    service_collection_invoices=BaselineInvoice.where("service_id=#{sid}")
    monthly_times_hash=service_collection_invoices.group(:month).count
    total_month_count=monthly_times_hash.count
    total_times_count=0
    monthly_times_hash.each do |key,times|
      total_times_count+=times
    end
    _monthly_collection=total_times_count.to_f/total_month_count
    _monthly_charge=_monthly_collection*(Service.find(sid).collection_rate)
    base_params={:monthly_collection=> _monthly_collection, :monthly_charge=>_monthly_charge,
                   :service_id=>sid}
    #BaselineData.create(monthly_collection: _monthly_collection,monthly_charge:_monthly_charge,
     #                     service_id:sid)
  end
end
