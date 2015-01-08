class Service < ActiveRecord::Base
  belongs_to :site
  has_many :baseline_invoices
end
