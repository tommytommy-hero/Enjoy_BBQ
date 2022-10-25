class Admin::ContactsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @contact = Contact.find(params[:id])
  end

  def index
    @all_contacts = Contact.all
    @contacts = Contact.order(created_at: :desc).page(params[:page])
  end

  def update
    @contact = Contact.find(params[:id])
    @contact.update(contact_params)
    redirect_to admin_root_path
  end

  private

  def contact_params
    params.require(:contact).permit(:process_status, :memo)
  end
end
