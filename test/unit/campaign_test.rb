require 'test_helper'

class CampaignTest < ActiveModel::TestCase
  def setup
    @account = accounts(:default)
    @campaign = Campaign.new
  end
  
  def test_should_validate_name
    assert_equal false, @campaign.valid?
    assert_equal ["can't be blank"], @campaign.errors[:name]
  end
  
  def test_should_validate_account
    assert_equal false, @campaign.valid?
    assert_equal ["can't be blank"], @campaign.errors[:account_id]
  end
  
  def test_should_be_valid
    @campaign.name = 'New Campaign'
    @campaign.account_id = @account.id
    assert_equal true, @campaign.valid?
  end
end