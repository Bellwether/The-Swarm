require 'test_helper'

class UserTest < ActiveModel::TestCase
  def setup
    @user = users(:default)
  end
end