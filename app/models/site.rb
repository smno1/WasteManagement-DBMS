class Site < ActiveRecord::Base
  belongs_to :company
  has_many :commentaries
  has_many :services
  has_many :contacts
end
