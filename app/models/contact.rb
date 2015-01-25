class Contact < ActiveRecord::Base
  include Filterable
  belongs_to :site
  
  scope :site_id, ->(site_id){where site_id:site_id}
  scope :contact_person, ->(name) {where("contact_person like ?", "%#{name}%")}
  scope :phone_number, ->(content) {where("phone_number like ?", "%#{content}%")}
  scope :email_address, ->(content) {where("email_address like ?", "%#{content}%")}

end
