require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  tests AccountsController
  
  def setup
    login!
  end

  test "should get show" do
    get :show
    assert_response :success, 'should respond with success'
    assert_template :show, 'should render show'
    assert_not_nil assigns[:account]
  end  
end