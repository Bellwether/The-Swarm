class Contact < ActiveRecord::Base
  belongs_to :account
  has_many :subscriptions
end