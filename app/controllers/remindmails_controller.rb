# encoding: utf-8
class RemindmailsController < ApplicationController
  before_action :set_remindmail, only: [:update, :destroy]

  def create
    if current_user.remindmails.count < 5 # リマインドメールの登録は一人5個まで
      @remindmail = Remindmail.new(remindmail_params)
      @remindmail.user = current_user
      respond_to do |format|
        if @remindmail.save
          format.html { redirect_to user_profile_url, notice: "送信用メールアドレスを作成しました" }
          #format.json { render :show, status: :ok, location: @user }
        else
          format.html { redirect_to user_profile_url(mail_error_messages: @remindmail.errors.messages, mail_error_details: @remindmail.errors.details, mail_error_state: "create"), flash: {error: "リマインドメールを作成できませんでした"} }
          #format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to user_profile_path, flash: {error: "リマインドメールは5個までです"}
    end
  end # create end

  def update
    respond_to do |format|
      if @remindmail.update(remindmail_params)
        format.html { redirect_to user_profile_url, notice: "送信用メールアドレスを更新しました" }
        #format.json { render :show, status: :ok, location: @user }
      else
        format.html { redirect_to user_profile_url(mail_error_messages: @remindmail.errors.messages, mail_error_details: @remindmail.errors.details, mail_error_state: @remindmail.id), flash: {error: "リマインドメールを更新できませんでした"} }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @remindmail.destroy
    respond_to do |format|
      format.html { redirect_to user_profile_url, notice: " 送信用メールアドレスを消去しました" }
      #format.json { head :no_content }
    end
  end # destroy end

  private

  def set_remindmail
    @remindmail = Remindmail.find(params[:id])
  end

  # strong_parameter
  def remindmail_params
    params.require(:remindmail).permit(:remind_email)
  end
end  #class end
