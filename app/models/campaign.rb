class Campaign < ActiveRecord::Base
  belongs_to :account, :counter_cache => true
  has_many :messages, :dependent => :destroy
  has_many :subscriptions, :dependent => :destroy  
  
  validates_presence_of :account_id
  validates_presence_of :name
  validates_format_of :name, :with => /^[\w-]+$/i, :message => 'must be letters or numbers',
                      :unless => Proc.new { |m| m.name.blank? }
  
  before_create :save_sns
  before_destroy :delete_sns
  
  def name=(v)
    write_attribute(:name, v ? v.upcase : v)
  end  
  
  def update_subscriptions
    missing_arn = subscriptions.where(:subscription_arn => nil)
    logger.info 'missing_arn = ' +missing_arn.inspect
    return if missing_arn.blank?

    topic = AWS::SNS::Topic.new self.topic_arn
    topic_subscriptions = topic.subscriptions
    missing_arn.each do |s|
      topic_subscriptions.each do |ts|
        if ts.endpoint.to_s == s.endpoint.to_s && ts.protocol.to_s == s.protocol.to_s
          s.update_attribute(:subscription_arn, ts.arn)
          break
        end
      end
    end
    return subscriptions
  end
    
  def save_sns
    topic_collection = AWS::SNS::TopicCollection.new
    topic = topic_collection.create name
    topic.display_name = name
    self.topic_arn = topic.arn
  end
  
  def delete_sns  
    topic = AWS::SNS::Topic.new self.topic_arn
    topic.delete
  end
end