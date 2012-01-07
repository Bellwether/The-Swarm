class LoginsController < ApplicationController
  def new
    @login = Login.new
  end
  
  def create
    if user = User.find_authenticated(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to root_path, :notice => "Logged in!"
    else
      @login = Login.new
      @login.errors.add(:email, "Invalid email or password")
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to new_login_path, :notice => "Logged out!"
  end
end