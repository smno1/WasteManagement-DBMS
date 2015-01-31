class Service < ActiveRecord::Base
  include Filterable
  belongs_to :site
  has_many :baseline_invoices, :dependent=>:delete_all
  has_many :current_invoices, :dependent=>:delete_all
  has_many :current_months, :dependent=>:delete_all
  has_one :baseline_datum, :dependent=>:delete
  has_many :saving_against_baselines, :dependent=>:delete_all
  
  scope :site_id, ->(site_id) {where site_id: site_id}
  
  before_destroy do |sv|
    unless Site.find_by_id(sv.site_id).blank?
      SiteMonthSaving.update_site_month_saving(sv.site_id)
      Site.update_running_total(sv.site_id)
    end
  end
end
