require 'test_helper'

class LoginsControllerTest < ActionController::TestCase
  tests LoginsController
  
  def setup
    @user = users(:default)
  end
  
  test "should get new" do
    get :new
    assert_response :success, 'should respond with success'
    assert_template :new, 'should render new'
    assert_not_nil assigns(:login)
    assert_tag :tag => "form", :attributes => { :action => login_url, :method => 'post' }
  end  
  
  test "should login" do  
    post :create, :email => @user.email, :password => 'pass'
    assert_response :redirect, 'should respond with redirect'
    assert_equal @user.id, session[:user_id], 'should store user id in session'
    assert_equal 'Logged in!', flash[:notice]
    assert_redirected_to root_path
  end
  
  test "should fail login" do  
    post :create, :email => @user.email, :password => 'bad'
    assert_response :success, 'should respond with success'
    assert_template :new, 'should render new'
    assert_not_nil assigns(:login)
    assert_not_nil assigns(:login).errors.full_messages
  end
  
  test "should logout" do
    session[:user_id] = @user.id
    delete :destroy    
    assert_response :redirect, 'should respond with redirect'
    assert_equal 'Logged out!', flash[:notice]
    assert_nil session[:user_id]
    assert_redirected_to new_login_path
  end
end