require 'test_helper'

class SubscriptionTest < ActiveModel::TestCase
  def setup
    @campaign = campaigns(:default)
    @contact = contacts(:default)
    @subscription = Subscription.new
  end
  
  def valid_subscription(protocol)
    @subscription = @contact.subscriptions.build
    @subscription.campaign = @campaign
    @subscription.protocol = protocol
    @subscription.set_endpoint
    @subscription
  end
  
  def test_should_be_confirmed
    assert_equal false, @subscription.confirmed?
    @subscription.subscription_arn = 'test'
    assert_equal true, @subscription.confirmed?
  end  
  
  def test_should_be_sms
    assert_equal false, @subscription.sms?
    @subscription.protocol = 'sms'
    assert_equal true, @subscription.sms?
  end
  
  def test_protocols
    assert_equal %w(sms email http https), Subscription.protocols
  end

  def test_should_numerize_endpoint_for_sms
    @subscription.protocol = 'sms'
    number = '1234567890'
    @subscription.endpoint = "#{number}abc"
    assert_equal number, @subscription.endpoint, 'should strip alpha characters'
  end
  
  def test_should_not_numerize_endpoint
    alphanumber = '1234567890abc'
    @subscription.endpoint = alphanumber
    assert_equal alphanumber, @subscription.endpoint, 'should not strip alpha characters'    
  end
  
  def test_should_downcase_protocol
    @subscription.protocol = 'SMS'
    assert_equal 'sms', @subscription.protocol
  end
  
  def test_should_validate_protocol
    assert_equal false, @subscription.valid?
    assert_equal ["can't be blank"], @subscription.errors[:protocol]
  end  
  
  def test_should_validate_campaign_id
    assert_equal false, @subscription.valid?
    assert_equal ["can't be blank"], @subscription.errors[:campaign_id]
  end
  
  def test_should_validate_contact_id
    assert_equal false, @subscription.valid?
    assert_equal ["can't be blank"], @subscription.errors[:contact_id]
  end    
  
  def test_should_validate_endpoint
    assert_equal false, @subscription.valid?
    assert_equal ["can't be blank"], @subscription.errors[:endpoint]
  end
  
  def test_should_validate_phone_endpoint_format
    @subscription = valid_subscription('sms')
    ['15615552323','1-561-555-1212','5613333'].each do |valid_number|
      @subscription.endpoint = valid_number
      @subscription.valid?
      assert_equal [], @subscription.errors[:endpoint]
    end
    
    ['1-555-5555','15553333','0-561-555-1212'].each do |invalid_number|
      @subscription.endpoint = invalid_number
      @subscription.valid?
      assert_equal ['must 7, 10, or 11 digit US phone number'], @subscription.errors[:endpoint]
    end    
  end
  
  def test_should_set_endpoint_with_sms
    @subscription = valid_subscription('sms')
    @subscription.save!
    
    assert_not_nil @subscription.endpoint
    assert_equal @contact.phone.gsub(/[^0-9]/, ""), @subscription.endpoint
  end
  
  def test_should_set_endpoint_with_email
    @subscription = valid_subscription('email')
    @subscription.save!
    
    assert_not_nil @subscription.endpoint
    assert_equal @contact.email, @subscription.endpoint
  end
  
  def test_should_subscribe_sns
    @subscription = valid_subscription('sms')
    @subscription.save!
    
    assert_not_nil @subscription.subscription_arn
  end
end