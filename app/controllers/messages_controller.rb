class MessagesController < ApplicationController
  def new
    @account = current_user.account
    @campaign = @account.campaigns.find_by_id(params[:campaign_id])
    @message = @campaign.messages.build
  end
  
  def create
    @account = current_user.account
    @campaign = @account.campaigns.find_by_id(params[:campaign_id])
    @message = @campaign.messages.new(params[:message])
    @message.user_id = current_user.id
    
    if @message.save
      flash[:notice] = "Message sent!"
      redirect_to campaign_path(@campaign)
    else
      render :action => "new"
    end    
  end
end