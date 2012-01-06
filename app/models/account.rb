class Account < ActiveRecord::Base
  has_many :users, :dependent => :destroy
  has_many :campaigns, :dependent => :destroy
  has_many :contacts, :dependent => :destroy
  
  validates_presence_of :name
end