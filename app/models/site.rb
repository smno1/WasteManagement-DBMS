class Site < ActiveRecord::Base
  include Filterable
  belongs_to :company
  has_many :commentaries
  has_many :services
  has_many :contacts
  
  scope :site_name, ->(name) {where("site_name like ?", "%#{name}%")}
  scope :company_id, ->(company_id) {where company_id: company_id}
end
