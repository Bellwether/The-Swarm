class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user, :logged_in?
    
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    current_user != nil
  end  
  
  def authenticate
    unless current_user
      flash[:error] = "You must log in"
      redirect_to new_login_path
      false
     end
  end
end
