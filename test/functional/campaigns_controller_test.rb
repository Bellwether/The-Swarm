require 'test_helper'

class CampaignsControllerTest < ActionController::TestCase
  tests CampaignsController
  
  def setup
    @campaign = campaigns(:default)
    login!
  end

  test "should get index" do
    get :index
    assert_template :index, 'should render index'
    assert_not_nil assigns[:campaigns]
  end
      
  test "should get new" do
    get :new
    assert_response :success, 'should respond with success'
    assert_template :new, 'should render new'
    assert_not_nil assigns[:campaign]
    assert_tag :tag => "form", :attributes => { :action => '/campaigns', :method => 'post' }
    assert_tag :tag => "input", :attributes => { :type => 'text', :name => 'campaign[name]' }
  end  
  
  test "should create" do  
    assert_difference('Campaign.count', 1) do
      post :create, :campaign => {:name => 'New Campaign'}
      assert_not_nil assigns[:campaign]
    end
    assert_equal 'Campaign created!', flash[:notice]
    assert_redirected_to campaign_path(assigns[:campaign])
  end
  
  test "should fail create" do  
    assert_no_difference('Campaign.count') do
      post :create
      assert_not_nil assigns[:campaign]
    end
    assert_template :new, 'should render new'    
  end
end