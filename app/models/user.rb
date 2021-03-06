class User < ActiveRecord::Base
  include Filterable
  acts_as_messageable
  belongs_to :company
  has_many :users_roles, :dependent=>:delete_all
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  scope :user_name, ->(user_name) {where("user_name like ?", "%#{user_name}%")}
  scope :email, ->(email) {where("email like ?","%#{email}%")}
  
  def mailboxer_email(object)
    email
  end
  def name
    user_name
  end
end
