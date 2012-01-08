require 'test_helper'

class ContactsControllerTest < ActionController::TestCase
  tests ContactsController
  
  def setup
    @contact = contacts(:default)
    login!
  end

  test "should get index" do
    get :index
    assert_template :index, 'should render index'
    assert_not_nil assigns[:contacts]
  end

  test "should get new" do
    get :new
    assert_response :success, 'should respond with success'
    assert_template :new, 'should render new'
    assert_not_nil assigns[:contact]    
    assert_tag :tag => "form", :attributes => { :action => '/contacts', :method => 'post' }
    assert_tag :tag => "input", :attributes => { :type => 'text', :name => 'contact[name]' }
    assert_tag :tag => "input", :attributes => { :type => 'tel', :name => 'contact[phone]' }        
  end  
  
  test "should get edit with subscriptions" do
    get :edit, :id => @contact.id
    assert_template :edit, 'should render edit'
    assert_not_nil assigns[:contact]
    assert_not_nil assigns[:subscriptions]    
  end  
  
  test "should get edit without subscriptions" do  
    @contact.subscriptions.destroy_all
    get :edit, :id => @contact.id
    assert_equal [], assigns[:subscriptions]
  end
  
  test "should create" do  
    assert_difference('Contact.count', 1) do
      post :create, :contact => {:name => 'New Contact', :phone => '555-555-5555', :email => 'new@example.com'}
      assert_not_nil assigns[:contact]
    end
    assert_equal 'Contact created!', flash[:notice]
    assert_redirected_to contacts_path
  end
  
  test "should fail create" do  
    assert_no_difference('Contact.count') do
      post :create
      assert_not_nil assigns[:contact]
    end
    assert_template :new, 'should render new'    
  end  
end