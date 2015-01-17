class Service < ActiveRecord::Base
  belongs_to :site
  has_many :baseline_invoices
  has_many :current_invoices
  has_many :current_months
  has_one :baseline_data
  has_many :saving_against_baselines
end
