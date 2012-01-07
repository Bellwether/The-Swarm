class AccountsController < ApplicationController
  before_filter :authenticate
  
  def show
    @account = current_user.account
  end
  
  def edit
  end
  
  def update
  end
end