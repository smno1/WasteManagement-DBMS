class SavingAgainstBaseline < ActiveRecord::Base
  include Filterable
  belongs_to :service  
  
  scope :service_id, ->(service_id){where service_id:service_id}
  scope :month, ->(month){where month:month}
  
  def self.create_sab_data(sid,mon)
    baselineData=BaselineDatum.find_by :service_id=> sid
    currentData=CurrentMonth.find_by :service_id=> sid, :month=>mon
    return nil if currentData.nil?
    _collection_saved=baselineData.monthly_collection.to_f-currentData.actual_month_collection
    _month_saving=baselineData.monthly_charge.to_f-currentData.actual_month_charge
    return SavingAgainstBaseline.create(service_id:sid, month:mon, collection_saved:_collection_saved, month_saving:_month_saving)
  end
  def self.update_sab_data(sab)
    baselineData=BaselineDatum.find_by :service_id=> sab.service_id
    currentData=CurrentMonth.find_by :service_id=> sab.service_id, :month=>sab.month
    return nil if currentData.nil?
    _collection_saved=baselineData.monthly_collection.to_f-currentData.actual_month_collection
    _month_saving=baselineData.monthly_charge.to_f-currentData.actual_month_charge
    _month_total_saving=_month_saving+sab.month_extra_saving
    sab.update(collection_saved: _collection_saved, month_saving:_month_saving,month_total_saving:_month_total_saving)
    return sab
  end
end
