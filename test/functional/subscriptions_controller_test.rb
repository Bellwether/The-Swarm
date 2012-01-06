require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  tests SubscriptionsController
  
  def setup
    @campaign = campaigns(:default)
    @contact = contacts(:default)
    login!
  end

  test "should get new" do
    get :new, :contact_id => @contact.id
    assert_response :success, 'should respond with success'
    assert_template :new, 'should render new'
    assert_not_nil assigns[:campaigns]
    assert_not_nil assigns[:contact]    
    assert_not_nil assigns[:subscription]
    assert_tag :tag => "form", :attributes => { :action => "/contacts/#{@contact.id}/subscriptions", :method => 'post' }
    assert_tag :tag => "select", :attributes => { :name => 'subscription[protocol]' }    
    assert_tag :tag => "select", :attributes => { :name => 'subscription[campaign_id]' }    
  end
  
  test "should create" do  
    assert_difference('Subscription.count', 1) do
      post :create, :contact_id => @contact.id, :subscription => {:protocol => 'sms', :campaign_id => @campaign.id}
      assert_not_nil assigns[:contact]
      assert_not_nil assigns[:subscription]
    end
    assert_equal 'Subscription created!', flash[:notice]
    assert_redirected_to edit_contact_path(@contact)
  end
  
  test "should fail create" do  
    assert_no_difference('Subscription.count') do
      post :create, :contact_id => @contact.id
      assert_not_nil assigns[:campaigns]
      assert_not_nil assigns[:contact]
      assert_not_nil assigns[:subscription]
    end
    assert_template :new, 'should render new'    
  end
  
  test "should destroy" do  
    @subscription = subscriptions(:default)
    assert_difference('Subscription.count', -1) do
      delete :destroy, :contact_id => @contact.id, :id => @subscription.id
    end
    assert_equal 'Subscription deleted!', flash[:notice]
    assert_redirected_to edit_contact_path(@contact)
  end        
end  