class Account < ActiveRecord::Base
  has_many :users
  has_many :campaigns
  has_many :contacts
end