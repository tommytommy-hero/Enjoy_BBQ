class Admin::HomesController < ApplicationController

  def top
    @contacts = Contact.all.order(created_at: :desc)
  end

end
