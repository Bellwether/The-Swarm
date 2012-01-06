class Campaign < ActiveRecord::Base
  belongs_to :account
  has_many :messages, :dependent => :destroy
  
  validates_presence_of :account_id
  validates_presence_of :name
  
  before_create :save_sns
  before_destroy :delete_sns
    
  def save_sns
    topic_collection = AWS::SNS::TopicCollection.new
    topic = topic_collection.create name    
    self.topic_arn = topic.arn
  end
  
  def delete_sns  
    topic = AWS::SNS::Topic.new self.topic_arn
    topic.delete
  end
end