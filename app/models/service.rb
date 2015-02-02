class Service < ActiveRecord::Base
  include Filterable
  belongs_to :site
  has_many :baseline_invoices, :dependent=>:delete_all
  has_many :current_invoices, :dependent=>:delete_all
  has_many :current_months, :dependent=>:delete_all
  has_one :baseline_datum, :dependent=>:delete
  has_many :saving_against_baselines, :dependent=>:delete_all
  
  scope :site_id, ->(site_id) {where site_id: site_id}
  
  after_update do |sv|
    if sv.changes.include?(:is_recycle)
      SiteMonthSaving.update_site_month_saving(sv.site_id)
    end
    if sv.changes.include?(:collection_rate)
      bd=sv.baseline_datum
      bd.update_column(:monthly_charge,bd.monthly_collection*sv.collection_rate) unless bd.blank?
      cms=sv.current_months
      unless cms.blank?
        cms.each do |cm|
          cm.update_column(:actual_month_charge,cm.actual_month_collection*sv.collection_rate)
        end
      end
      s_sabs=sv.saving_against_baselines
      unless s_sabs.blank?
        s_sabs.each do |sab|
          SavingAgainstBaseline.update_sab_data(sab)
        end
      end
    end
  end
  
  after_destroy do |sv|
    unless Site.find_by_id(sv.site_id).blank?
      SiteMonthSaving.update_site_month_saving(sv.site_id)
      sv.site.update_running_total
    end
  end
end
