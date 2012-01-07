require 'test_helper'

class ContactTest < ActiveModel::TestCase
  def setup
    @account = accounts(:default)
    @contact = Contact.new
  end
  
  def test_should_validate_name
    assert_equal false, @contact.valid?
    assert_equal ["can't be blank"], @contact.errors[:name]
  end
  
  
  def test_should_validate_phone
    ['15615552323','1-561-555-1212','5613333'].each do |valid_number|
      @contact.phone = valid_number
      @contact.valid?
      assert_equal [], @contact.errors[:phone]
    end
    
    ['1-555-5555','15553333','0-561-555-1212'].each do |invalid_number|
      @contact.phone = invalid_number
      @contact.valid?
      assert_equal ['must 7, 10, or 11 digit US phone number'], @contact.errors[:phone]
    end    
  end  
end