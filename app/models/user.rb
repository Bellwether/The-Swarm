class User < ActiveRecord::Base
  belongs_to :account
  
  has_secure_password
  validates :password, :presence => { :on => :create }
  
  def self.find_authenticated(email=nil, password=nil)
    user = User.find_by_email(email)
    return user && user.authenticate(password) ? user : nil
  end
end