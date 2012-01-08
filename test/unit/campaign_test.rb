require 'test_helper'

class CampaignTest < ActiveModel::TestCase
  def setup
    @account = accounts(:default)
    @campaign = Campaign.new
  end

  def test_should_upcase_name
    name = 'lowercase name'
    @campaign.name = name
    assert_equal name.upcase, @campaign.name
  end
  
  def test_should_validate_name
    assert_equal false, @campaign.valid?
    assert_equal ["can't be blank"], @campaign.errors[:name]
  end
  
  def test_should_validate_name_format
    bad_names = ['bad!','b a d', 'b.']
    bad_names.each do |name|
      @campaign.name = name
      assert_equal false, @campaign.valid?
      assert_equal ["must be letters or numbers"], @campaign.errors[:name]
    end
  end
  
  def test_should_validate_account
    assert_equal false, @campaign.valid?
    assert_equal ["can't be blank"], @campaign.errors[:account_id]
  end
  
  def test_should_be_valid
    @campaign.name = 'New-Campaign-100'
    @campaign.account_id = @account.id
    assert_equal true, @campaign.valid?
  end

  def test_should_update_subscriptions
    @campaign = campaigns(:default)
    @campaign.subscriptions.update_all(:subscription_arn => nil)
    assert_equal @campaign.subscriptions, @campaign.update_subscriptions
  end
      
  def test_should_not_update_subscriptions
    assert_nil @campaign.update_subscriptions
  end
end