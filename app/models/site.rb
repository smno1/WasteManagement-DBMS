class Site < ActiveRecord::Base
  include Filterable
  belongs_to :company
  has_many :commentaries, :dependent=>:destroy
  has_many :services, :dependent=>:destroy
  has_many :contacts, :dependent=>:destroy
  has_many :site_month_savings, :dependent=>:destroy
  has_many :site_yearly_records, :dependent=>:destroy
  has_many :saving_against_baselines, :through=> :services
  has_many :baseline_data, :through=> :services
  has_many :current_months, :through=> :services
  
  scope :site_name, ->(name) {where("lower(site_name) like lower(?)", "%#{name}%")}
  scope :company_id, ->(company_id) {where company_id: company_id}
 
  def update_running_total
    unless self.saving_against_baselines.blank?
      _running_total=self.saving_against_baselines.sum(:month_total_saving)
      self.update(running_total:_running_total)
    end
  end
  
  def update_fy_saving
    sabs=self.saving_against_baselines.betweenDate(DataUtil.get_current_fy_start_date,Date.today)
    unless sabs.blank?
      fy_saving=sabs.sum(:month_total_saving)
      self.update(current_fy_saving:fy_saving)
    end    
  end
  
  def update_fy_cost
    cmonth=current_months.where(:month=>DataUtil.get_current_fy_start_date..Date.today)
    unless cmonth.blank?
      fy_cost=cmonth.sum(:actual_month_charge)
      self.update(current_fy_cost:fy_cost)
    end    
  end
  
end
