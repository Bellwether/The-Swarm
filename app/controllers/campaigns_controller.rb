class CampaignsController < ApplicationController
  def index
    @campaigns = Campaign.find_all_by_account_id(current_user.account_id)
  end
  
  def new
    @campaign = Campaign.new
  end
  
  def show
    @account = current_user.account
    @campaign = @account.campaigns.find(params[:id])
    @subscriptions = @campaign.subscriptions
  end
  
  def create
    @campaign = Campaign.new(params[:campaign])
    @campaign.account_id = current_user.account_id
    
    if @campaign.save
      flash[:notice] = "Campaign created!"
      redirect_to campaign_path(@campaign)
    else
      render :action => "new"
    end      
  end
  
  def destroy
    @account = current_user.account
    @campaign = @account.campaigns.find(params[:id])    
    @campaign.destroy
    flash[:notice] = "Campaign deleted!"
    
    redirect_to campaigns_path
  end
end