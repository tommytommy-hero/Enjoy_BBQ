class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @contacts = Contact.includes([:user]).order(created_at: :desc)
  end

end
