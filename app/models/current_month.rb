class CurrentMonth < ActiveRecord::Base
  include Filterable
  
  belongs_to :service
  
  scope :service_id, ->(id){where service_id:id}
  
  after_update do |cm|
    sab=SavingAgainstBaseline.find_by :service_id=>cm.service_id, :month=>cm.month
    SavingAgainstBaseline.update_sab_data(sab) unless sab.blank?
  end
  
  def self.create_current_month_data(sid, mon)
    self.create(self.current_month_params(sid,mon))
  end
 
  def self.update_current_month_data(sid,mon)
    current_month_data=self.find_or_initialize_by(service_id: sid, month: mon)
    current_month_data.update(self.current_month_params(sid, mon))
    #current_month_data=CurrentMonth.where("service_id=#{sid} and Month=?",mon)
    #current_month_data.delete_all unless current_month_data.blank?
    #self.create_current_month_data(sid, mon)
  end
 
  private
 
  def self.current_month_params(sid, mon)
    current_month_invoices=CurrentInvoice.where("service_id=#{sid} and month=?",mon)
    return if current_month_invoices.blank?
    service=Service.find(sid)
    _month_total_tonnes=0
    _month_average_load=0
    _actual_month_collection=current_month_invoices.count
    _actual_month_charge=_actual_month_collection*service.collection_rate
    _optimal_collection=0
    _days_interval=0
    current_month_invoices.each do |c_m_i|
      _month_total_tonnes+=c_m_i.tonnes
    end
    _month_average_load=_month_total_tonnes.to_f/_actual_month_collection
    highest_actual_load=[CurrentInvoice.maximum(:tonnes),BaselineInvoice.maximum(:tonnes)].max
    puts highest_actual_load
    _optimal_collection=_month_total_tonnes.to_f/highest_actual_load
    _days_interval=365.0/12/_optimal_collection
    current_month={service_id: sid,month: mon,month_total_tonnes: _month_total_tonnes,
          month_average_load: _month_average_load, actual_month_collection: _actual_month_collection,
          actual_month_charge: _actual_month_charge, optimal_collection: _optimal_collection,
          days_interval: _days_interval}
  end
end
