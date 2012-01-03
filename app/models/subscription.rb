class Subscription < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :contact  
end