class Company < ActiveRecord::Base
  include Filterable
  has_many :sites
  scope :client_name, ->(name) {where("client_name like ?", "#{name}%")}
  
end
