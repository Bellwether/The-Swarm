require 'test_helper'
 
class PageDataUrlTest < ActionDispatch::IntegrationTest
  fixtures :users
  
  test "application layout contains data-url attribute on page tag" do  
    get "/login/new"
    assert_tag :tag => "div", :attributes => { 'data-role' => 'page', 'data-url' => @controller.request.url }
    
    open_session do |user|
      user.session[:user_id] = users(:default).id
      user.get "/campaigns"
      assert_tag :tag => "div", :attributes => { 'data-role' => 'page', 'data-url' => @controller.request.url }
    end
  end
end