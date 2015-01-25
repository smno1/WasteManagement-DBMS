class Commentary < ActiveRecord::Base
  include Filterable
  belongs_to :site
  
  scope :site_id, ->(site_id){where site_id:site_id}
  scope :month, ->(month){where month:month}
  scope :comments, ->(content) {where("comments like ?", "%#{content}%")}
  
end
