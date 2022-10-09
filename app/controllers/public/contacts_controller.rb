class Public::ContactsController < ApplicationController

  def index
    @contact = Contact.new
    @contacts = Contact.all.order(created_at: "DESC")
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.user_id = current_user.id
    if @contact.save
      redirect_to request.referer
      flash[:notice] = "お問合せありがとうございます。
                        後ほどメールにてご連絡差し上げますので今しばらくお待ちください。"
    else
      @contacts = Contact.all
      render 'index'
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:content)
  end

end
