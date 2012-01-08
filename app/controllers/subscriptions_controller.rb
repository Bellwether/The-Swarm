class SubscriptionsController < ApplicationController
  before_filter :authenticate
  
  def new
    @account = current_user.account
    @contact = @account.contacts.find_by_id(params[:contact_id]) 
    @campaigns = Campaign.find_all_by_account_id(current_user.account_id)
    @subscription = @contact.subscriptions.build
    @subscription.protocol = 'sms'
  end
  
  def create
    @account = current_user.account
    @contact = @account.contacts.find_by_id(params[:contact_id])
    @subscription = @contact.subscriptions.new(params[:subscription])
    @subscription.campaign_id = @account.campaigns.find(@subscription.campaign_id).id if @subscription.campaign_id

    if @subscription.save
      flash[:notice] = "Subscription created!"
      redirect_to edit_contact_path(@contact)
    else
      @campaigns = Campaign.find_all_by_account_id(current_user.account_id)
      render :action => "new"
    end
  end
  
  def destroy
    @account = current_user.account
    @contact = @account.contacts.find(params[:contact_id])    
    @subscription = @contact.subscriptions.find(params[:id])
    @subscription.destroy
    flash[:notice] = "Subscription deleted!"
    
    redirect_to edit_contact_path(@contact)
  end
end