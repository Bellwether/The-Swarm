class Campaign < ActiveRecord::Base
  belongs_to :account
  has_many :messages
end