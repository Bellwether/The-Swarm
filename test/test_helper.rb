ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
  def login!(user=nil)
    session[:user_id] = user ? user.id : users(:default).id
  end
  
  def logout!
    session[:user_id] = nil
  end
  
  AWS.stub!
end

module AWS
  class SNS
    class Topic
      def display_name= display_name
        display_name
      end
            
      def publish msg, opts = {}
        return 'aws-1234567890-0987654321' # mock message id response
      end
      
      def subscribe endpoint, opts = {}
        Subscription.new 'aws-1234567890-0987654321' # mock subscription object
      end
    end
  end
end