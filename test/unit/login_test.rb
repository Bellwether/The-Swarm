require 'test_helper'

class SessionTest < ActiveModel::TestCase  
  include ActiveModel::Lint::Tests
  
  def setup
    @login = @model = Login.new
  end  
  
  def test_should_validate_email
    assert_equal false, @login.valid?
    assert_equal ["can't be blank"], @login.errors[:email]
  end
  
  def test_should_validate_password
    assert_equal false, @login.valid?
    assert_equal ["can't be blank"], @login.errors[:password]
  end  
  
  def test_should_be_valid
    @login.email = 'test@example.com'
    @login.password = 'test'    
    assert_equal true, @login.valid?
  end
end