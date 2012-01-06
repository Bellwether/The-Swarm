require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  tests MessagesController
  
  def setup
    @campaign = campaigns(:default)
    login!
  end

  # test "should get new" do
  #   get :new, :campaign_id => @campaign.id
  #   assert_response :success, 'should respond with success'
  #   assert_template :new, 'should render new'
  #   assert_not_nil assigns[:campaign]
  #   assert_not_nil assigns[:message]    
  #   assert_tag :tag => "form", :attributes => { :action => "/campaigns/#{@campaign.id}/messages", :method => 'post' }
  #   assert_tag :tag => "input", :attributes => { :type => 'text', :name => 'message[subject]' }
  #   assert_tag :tag => "textarea", :attributes => { :name => 'message[body]' }      
  # end  
  
  test "should create" do  
    assert_difference('Message.count', 1) do
      post :create, :campaign_id => @campaign.id, :message => {:subject => 'New Message', :body => 'Test.'}
      assert_not_nil assigns[:message]
    end
    assert_equal 'Message sent!', flash[:notice]
    assert_redirected_to campaign_path(@campaign)
  end
  
  # test "should fail create" do  
  #   assert_no_difference('Message.count') do
  #     post :create, :campaign_id => @campaign.id
  #     assert_not_nil assigns[:campaign]
  #     assert_not_nil assigns[:message]
  #   end
  #   assert_template :new, 'should render new'    
  # end  
end