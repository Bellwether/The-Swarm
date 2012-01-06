class Message < ActiveRecord::Base
  belongs_to :campaign  
  belongs_to :user
  
  validates_presence_of :subject, :campaign_id, :body
  validates :subject, :length => { :maximum => 99 }
  
  before_create :publish_sns    
  
  def sms_body
    body ? body[0..140] : ''
  end
  
  def publish_sns
    topic = AWS::SNS::Topic.new campaign.topic_arn
    topic.publish sms_body
  end
end