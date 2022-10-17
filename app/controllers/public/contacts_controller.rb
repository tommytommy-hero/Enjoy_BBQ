class Public::ContactsController < ApplicationController
  before_action :authenticate_user!

  def index
    @contact = Contact.new
    @contacts = Contact.includes([:user]).order(created_at: "DESC")
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.user_id = current_user.id
    if @contact.save
      redirect_to request.referer
      flash[:contact] = "お問合せありがとうございます。
                        後ほどメールにてご連絡差し上げますので今しばらくお待ちください。"
    else
      @contacts = Contact.all
      flash.now[:sign] = "ご記入の上、送信してください。"
      render 'index'
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:content)
  end

end
