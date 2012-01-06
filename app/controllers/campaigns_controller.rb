class CampaignsController < ApplicationController
  def index
    @campaigns = Campaign.find_by_account_id(current_user.account_id)
  end
  
  def new
    @campaign = Campaign.new
  end
  
  def show
    @campaign = Campaign.find(params[:id])
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
end