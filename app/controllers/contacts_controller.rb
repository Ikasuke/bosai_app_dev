# encoding: utf-8
class ContactsController < ApplicationController
  def new
    @contact = Contact.new
    @contact.contact_email = current_user.email
    if params[:error_messages].nil?
      # エラーなしの場合 = 送信する前
      @error_details = {key: "no_error"}   #ダミーのkeyとvalueを入れておく エラー防止
    else
      #validationのエラー表示用
      @error_messages = params[:error_messages]   # エラーのメッセージ
      @error_details = params[:error_details]     #エラーが表示された部分が格納
      @contact.contact_name = params[:contact_name]
      @contact.contact_email = params[:contact_email]
      @contact.message = params[:message]
    end

    if browser.device.mobile? #browser.chrome? #
    else
      render :layout => "startpage.html.erb"
    end
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.valid?
      ContactMailer.send_mailer(@contact).deliver
      redirect_to home_url, notice: "正常に送信しました。 お問い合わせいただきありがとうございました。"
    else
      redirect_to new_contact_url(contact_name: @contact.contact_name, contact_email: @contact.contact_email, message: @contact.message, error_messages: @contact.errors.messages, error_details: @contact.errors.details), flash: {error: "問い合わせを送信できませんでした"}
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:contact_name, :contact_email, :message)
  end
end
