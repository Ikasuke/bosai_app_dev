# encoding: utf-8
class UsersController < ApplicationController
  def profile
    @user = current_user
    # リマインドメールを表示するために登録されているものを呼び出す。なければ新規登録のみ表示する。
    remindmails = current_user.remindmails
    if remindmails.empty?
      # 新規に作るようにする controllerではなにもしない
      @loginmail = false  # ログイン用メールアドレスをリマインドメールに使用しているか？=> していないのでfalse
    else
      @remindmails = remindmails
      @loginmail = false   # ログイン用メールアドレスをリマインドメールに使用しているか？ trueなら使用している
      @remindmails.each do |remindmail|
        if remindmail.remind_email == @user.email
          @loginmail = true
          @loginmail_id = remindmail.id
        else
        end
      end
    end
    if params[:u_error_messages].nil?
      @u_error_details = {key: "no_error"}   #ダミーのkeyとvalueを入れておく エラー防止
    else
      #validationのエラー表示用
      @u_error_messages = params[:u_error_messages]   # エラーのメッセージ
      @u_error_details = params[:u_error_details]     #エラーが表示された部分が格納
    end
    if params[:mail_error_messages].nil?
      @mail_error_details = {key: "no_error"}   #ダミーのkeyとvalueを入れておく エラー防止
    else
      #validationのエラー表示用
      @mail_error_messages = params[:mail_error_messages]   # エラーのメッセージ
      @mail_error_details = params[:mail_error_details]     #エラーが表示された部分が格納
      @mail_error_state = params[:mail_error_state]        # create => 新規作成　id => idに該当するアドレスのアップデート　でエラー
    end
  end # profile end

  def update
    @user = current_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to home_url, notice: "正常にアップデートされました" }
        #format.json { render :show, status: :ok, location: @user }
      else
        format.html { redirect_to user_profile_path(u_error_messages: @user.errors.messages, u_error_details: @user.errors.details), flash: {error: "アップデートできませんでした"} }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def area
  end

  def show
    @user = User.find(params[:id])
  end

  private

  # strong_parameter :public_name, :area,
  def user_params
    params.require(:user).permit(:public_name, :area1, :area2, :family, :avatar, :profile)
  end
end
