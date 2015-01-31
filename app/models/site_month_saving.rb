class SiteMonthSaving < ActiveRecord::Base
  include Filterable
  belongs_to :site
  scope :site_id, ->(site_id){where site_id:site_id}
  
  def self.update_when_saving_against_baseline_changed(sid,month)
    _site=Site.find(sid)
    sabs=_site.saving_against_baselines.where :month=>month
    sms=self.find_or_initialize_by :site_id=>_site.id, :month=>month
    _month_saving=sabs.sum(:month_total_saving)
    recycling_tonnes=0.0
    total_tonnes=0
    _services=_site.services
    _services.each do |s|
      service_sum=s.current_invoices.where(:month=>month).sum(:tonnes)
      recycling_tonnes+=service_sum if s.is_recycle
      total_tonnes+=service_sum
    end
    _recycling_rate=total_tonnes==0? 0 : recycling_tonnes/total_tonnes
    sms.update(month_saving:_month_saving,recycling_rate:_recycling_rate)
  end
  
  def self.update_site_month_saving(sid)
    site_sab=Site.find_by_id(sid).saving_against_baselines.group(:month)
    unless site_sab.blank?
      site_sab.each do |sab|
        self.update_when_saving_against_baseline_changed(sab.service.site_id,sab.month)
      end
    end
  end
end
