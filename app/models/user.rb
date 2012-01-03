class User < ActiveRecord::Base
  belongs_to :account
  
  has_secure_password
  validates :password, :presence => { :on => :create }
end