class Contact < ActiveRecord::Base
  belongs_to :account
  has_many :subscriptions, :dependent => :destroy
  
  validates_presence_of :name
end