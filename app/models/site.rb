class Site < ActiveRecord::Base
  include Filterable
  belongs_to :company
  has_many :commentaries, :dependent=>:destroy
  has_many :services, :dependent=>:destroy
  has_many :contacts, :dependent=>:destroy
  has_many :site_month_savings, :dependent=>:destroy
  has_many :saving_against_baselines, :through=> :services
  has_many :baseline_data, :through=> :services
  has_many :current_months, :through=> :services
  
  scope :site_name, ->(name) {where("site_name like ?", "%#{name}%")}
  scope :company_id, ->(company_id) {where company_id: company_id}
 
  def update_running_total
    unless self.saving_against_baselines.blank?
      _running_total=self.saving_against_baselines.sum(:month_total_saving)
      self.update(running_total:_running_total)
    end
  end
  
  def update_fy_saving
    today=Date.today
    july=Date.new(today.year,7,1)
    july=july.last_year if(today<july)
    sabs=self.saving_against_baselines.betweenDate(july,today)
    unless sabs.blank?
      fy_saving=sabs.sum(:month_total_saving)
      self.update(current_fy_saving:fy_saving)
    end    
  end
  
end
