class LoginsController < ApplicationController
  def new
    @login = Login.new
  end
  
  def create
    @login = Login.new(params[:login])
    
    if user = @login.find_authenticated
      session[:user_id] = user.id
      redirect_to root_path, :notice => "Logged in!"
    else
      @login.errors.add(:email, "Invalid email or password")
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to new_login_path, :notice => "Logged out!"
  end
end