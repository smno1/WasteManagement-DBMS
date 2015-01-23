class SavingAgainstBaseline < ActiveRecord::Base
  belongs_to :service  
  def self.create_sab_data(sid,mon)
    baselineData=BaselineDatum.find_by :service_id=> sid
    currentData=CurrentMonth.find_by :service_id=> sid, :Month=>mon
    return nil if currentData.nil?
    _collection_saved=baselineData.monthly_collection.to_f-currentData.actual_month_collection
    _month_saving=baselineData.monthly_charge.to_f-currentData.actual_month_charge
    return SavingAgainstBaseline.create(service_id:sid, month:mon, collection_saved:_collection_saved, month_saving:_month_saving)
  end
  def self.update_sab_data(sab)
    baselineData=BaselineDatum.find_by :service_id=> sab.service_id
    currentData=CurrentMonth.find_by :service_id=> sab.service_id, :Month=>sab.month
    return nil if currentData.nil?
    _collection_saved=baselineData.monthly_collection.to_f-currentData.actual_month_collection
    _month_saving=baselineData.monthly_charge.to_f-currentData.actual_month_charge
    sab.update(collection_saved: _collection_saved, month_saving:_month_saving)
    return sab
  end
end
