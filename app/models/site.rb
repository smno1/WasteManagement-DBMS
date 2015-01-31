class Site < ActiveRecord::Base
  include Filterable
  belongs_to :company
  has_many :commentaries, :dependent=>:destroy
  has_many :services, :dependent=>:destroy
  has_many :contacts, :dependent=>:destroy
  has_many :site_month_savings, :dependent=>:destroy
  has_many :saving_against_baselines, :through=> :services
  
  scope :site_name, ->(name) {where("site_name like ?", "%#{name}%")}
  scope :company_id, ->(company_id) {where company_id: company_id}
 
  def self.update_running_total(sid)
    _site=Site.find(sid)
    _running_total=_site.saving_against_baselines.sum(:month_total_saving)
    _site.update(running_total:_running_total)
  end
  
end
