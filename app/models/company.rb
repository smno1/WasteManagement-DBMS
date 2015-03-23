class Company < ActiveRecord::Base
  include Filterable
  has_many :sites, :dependent=>:destroy
  has_many :users, :dependent=>:destroy
  has_many :saving_against_baselines, :through=> :sites
  has_many :site_month_savings, :through=>:sites
  has_many :site_yearly_records, :through=>:sites

  scope :client_name, ->(name) {where("lower(client_name) like lower(?)", "%#{name}%")}
  
end
