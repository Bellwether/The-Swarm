require 'test_helper'

class MessageTest < ActiveModel::TestCase
  def setup
    @campaign = campaigns(:default)
    @message = Message.new
  end
  
  def test_should_validate_subject
    assert_equal false, @message.valid?
    assert_equal ["can't be blank"], @message.errors[:body]
  end
  
  def test_should_validate_campaign
    assert_equal false, @message.valid?
    assert_equal ["can't be blank"], @message.errors[:campaign_id]
  end
  
  def test_should_validate_body
    assert_equal false, @message.valid?
    assert_equal ["can't be blank"], @message.errors[:body]
  end
  
  def test_should_validate_subject_length
    @message.subject = ''
    100.times { |i| @message.subject << '*' }
    assert_equal false, @message.valid?
    Rails.logger.info @message.errors    
    assert_equal ['is too long (maximum is 99 characters)'], @message.errors[:subject]
  end

  def test_sms_body
    assert_equal '', @message.sms_body
    @message.body = ''
    1000.times { |i| @message.body << '*' }
    assert_equal @message.body[0..140], @message.sms_body
  end
  
  def test_set_subject
    @message.send(:set_subject)
    assert_equal 'MSG', @message.subject
    @message.subject = 'test'
    @message.send(:set_subject)
    assert_equal 'test', @message.subject
  end 
  
  def test_set_subject_before_validation
    @message.save
    assert_equal 'MSG', @message.subject
  end
end