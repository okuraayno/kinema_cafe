class Admin::ContactsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @contacts = Contact.all
  end
  
  def show
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    @contact.update(contact_params)
    flash[:notice] = "対応ステータスを変更しました"
    redirect_back(fallback_location: root_path)
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :name, :message, :completed)
  end

end
