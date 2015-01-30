class SiteMonthSaving < ActiveRecord::Base
  include Filterable
  belongs_to :site
  scope :site_id, ->(site_id){where site_id:site_id}
  def self.update_when_saving_against_baseline_changed(sab)
    _service=sab.service
    _site=_service.site
    sabs=_site.saving_against_baselines.where :month=>sab.month
    sms=self.find_or_initialize_by :site_id=>_site.id, :month=>sab.month
    _month_saving=sabs.sum(:month_total_saving)
    recycling_tonnes=0.0
    total_tonnes=0
    _services=_site.services
    _services.each do |s|
      service_sum=s.current_invoices.where(:month=>sab.month).sum(:tonnes)
      recycling_tonnes+=service_sum if s.is_recycle
      total_tonnes+=service_sum
    end
    _recycling_rate=total_tonnes==0? 0 : recycling_tonnes/total_tonnes
    sms.update(month_saving:_month_saving,recycling_rate:_recycling_rate)
  end
  
end
