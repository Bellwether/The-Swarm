class User < ActiveRecord::Base
  belongs_to :account, :counter_cache => true
  
  has_secure_password
  validates :password, :presence => { :on => :create }
end