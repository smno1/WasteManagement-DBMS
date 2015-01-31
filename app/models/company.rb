class Company < ActiveRecord::Base
  include Filterable
  has_many :sites, :dependent=>:destroy_all
  has_many :saving_against_baselines, :through=> :sites

  scope :client_name, ->(name) {where("client_name like ?", "%#{name}%")}
  
end
