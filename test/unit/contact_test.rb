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
end