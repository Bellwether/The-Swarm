class Subscription < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :contact  
  
  PROTOCOLS = %w(sms email http https)

  validates_presence_of :campaign_id
  validates_presence_of :contact_id
  validates_presence_of :endpoint  
  validates_presence_of :protocol
  validates_inclusion_of :protocol, :in => PROTOCOLS, 
                         :message => "must be 'sms', 'email', 'http', or 'https'",
                         :unless => Proc.new { |m| m.protocol.blank? }

  before_validation :set_endpoint
  before_create :subscribe_sns  
  before_destroy :unsubscribe_sns

  def confirmed?
    !subscription_arn.blank?
  end
  
  def protocol=(v)
    write_attribute(:protocol, v ? v.downcase : v)
  end
                         
  def self.protocols
    PROTOCOLS
  end
  
  def set_endpoint
    return unless endpoint.blank?
    
    self.endpoint = if protocol == 'sms'
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