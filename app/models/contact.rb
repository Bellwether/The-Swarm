class Contact < ActiveRecord::Base
  belongs_to :account
  has_many :subscriptions, :dependent => :destroy
  
  validates_presence_of :name
  validates_format_of :phone, :with => /^(1?(-?\d{3})-?)?(\d{3})(-?\d{4})$/, :message => 'must 7, 10, or 11 digit US phone number',
                      :unless => Proc.new { |m| m.phone.blank? }  
end