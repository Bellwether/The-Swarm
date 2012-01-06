class ContactsController < ApplicationController
  def index
    @contacts = Contact.find_by_account_id(current_user.account_id)    
  end

  def new
    @account = current_user.account
    @contact = @account.contacts.build
  end

  def edit
    @contact = Contact.find_by_id_and_account_id(params[:id], current_user.account_id)
    @subscriptions = @contact.subscriptions.includes(:campaign)
  end

  def create
    @account = current_user.account
    @contact = @account.contacts.new(params[:contact])

    if @contact.save
      flash[:notice] = "Contact created!"
      redirect_to contacts_path
    else
      render :action => "new"
    end      
  end
end