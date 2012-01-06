require 'test_helper'

class UserTest < ActiveModel::TestCase
  def setup
    @user = users(:default)
  end
  
  def test_should_authenticate
    assert user = User.find_authenticated(@user.email, 'pass')
    assert_equal user.id, @user.id
  end

  def test_should_not_authenticate_without_credentials
    assert_nil User.find_authenticated
  end
  
  def test_should_not_authenticate_with_bad_email
    assert_nil User.find_authenticated('bad', 'pass')
  end
  
  def test_should_not_authenticate_with_bad_password
    assert_nil User.find_authenticated('default@example.com', 'bad')
  end
end