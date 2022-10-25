class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @all_contacts = Contact.all
    @contacts = Contact.includes([:user]).order(created_at: :desc).page(params[:page])
  end

end
