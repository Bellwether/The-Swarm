require 'test_helper'

class SessionTest < ActiveModel::TestCase  
  include ActiveModel::Lint::Tests
  
  def setup
    @login = @model = Login.new
    @user = users(:default)
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

  def test_should_not_authenticate_without_credentials
    assert_nil @login.find_authenticated
  end

  def test_should_not_authenticate_with_bad_email
    @login = Login.new(:email => 'bad', :password => 'pass')
    assert_nil @login.find_authenticated
  end

  def test_should_not_authenticate_with_bad_password
    @login = Login.new(:email => @user.email, :password => 'bad')
    assert_nil @login.find_authenticated
  end

  def test_should_authenticate
    @login = Login.new(:email => @user.email, :password => 'pass')    
    assert user = @login.find_authenticated
    assert_equal user.id, @user.id
  end
end