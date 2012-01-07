class Subscription < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :contact  
  
  PROTOCOLS = %w(sms email http https)

  validates_presence_of :campaign_id
  validates_presence_of :contact_id
  validates_presence_of :protocol
  validates_inclusion_of :protocol, :in => PROTOCOLS, 
                         :message => "must be 'sms', 'email', 'http', or 'https'",
                         :unless => Proc.new { |m| m.protocol.blank? }
  validates_presence_of :endpoint
  validates_format_of :endpoint, :with => /^(1?(-?\d{3})-?)?(\d{3})(-?\d{4})$/, :message => 'must 7, 10, or 11 digit US phone number',
                      :unless => Proc.new { |m| m.endpoint.blank? || !m.sms? }

  before_validation :set_endpoint
  before_create :subscribe_sns  
  before_destroy :unsubscribe_sns

  def confirmed?
    !subscription_arn.blank?
  end
  
  def sms?
    protocol == 'sms'
  end

  def endpoint=(v)
    v = v && sms? ? v.to_s.gsub(/[^0-9]/, "") : v
    write_attribute(:endpoint, v)
  end
  
  def protocol=(v)
    write_attribute(:protocol, v ? v.downcase : v)
  end
                         
  def self.protocols
    PROTOCOLS
  end
  
  def set_endpoint
    return unless endpoint.blank?
    
    self.endpoint = if sms?
      contact.phone
    elsif protocol == 'email'
      contact.email
    end
  end
  
  def subscribe_sns
    topic = AWS::SNS::Topic.new campaign.topic_arn
    subscription = topic.subscribe endpoint
    self.subscription_arn = subscription.arn if subscription
  end
  
  def unsubscribe_sns  
    return if subscription_arn.blank?
    subscription = AWS::SNS::Subscription.new subscription_arn
    subscription.unsubscribe
  end
end