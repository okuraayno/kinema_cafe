class User::ContactsController < ApplicationController
  before_action :authenticate_user!

  def new
    @contact = Contact.new
  end

  def confirm
    @contact = Contact.new(contact_params)
    if @contact.invalid?
      render :new
    end
  end

  def back
    @contact = Contact.new(contact_params)
    render :new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to done_path
    else
      render :new
    end
  end

  def done
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :name, :message)
  end

end
