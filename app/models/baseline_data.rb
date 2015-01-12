class BaselineData < ActiveRecord::Base
  def self.recalculate_baseline_data
    BaselineData.delete_all
    baseline_invoices=BaselineInvoice.all
    service_grouped_invoices=baseline_invoices.group('service_id')
    service_grouped_invoices.each do |s_g_i|
      service_collection_invoices=BaselineInvoice.where("service_id=#{s_g_i.service.id}")
      monthly_times_hash=service_collection_invoices.group(:Month).count
      total_month_count=monthly_times_hash.count
      total_times_count=0
      monthly_times_hash.each do |key,times|
        total_times_count+=times
      end
      _monthly_collection=total_times_count.to_f/total_month_count
      _monthly_charge=_monthly_collection*(s_g_i.service.collection_rate)
      BaselineData.create(monthly_collection: _monthly_collection,monthly_charge:_monthly_charge)  
    end
  end
end
