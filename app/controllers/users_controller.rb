# encoding: utf-8
class UsersController < ApplicationController
  PER = 12

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

    ## 人数用
    @volume_selects = Array.new()
    21.times do |t|
      @volume_selects.push(t)
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

  def area_city
  end

  def show # カテゴリーごとに別れたアイテムを表示する
    @user = User.find(params[:id])
    ## カテゴリー
    @categories = Category.all
    @item_cate_sort = {}

    if params[:tab] == "tab_category" #この時、tab1~3のpaginateが押された
      @items_array = Array.new()
      #押されたpaginateのカテゴリだけpaginate
      items_subcate = @user.items.where(subcategory_id: params[:subcategory_id].to_i).where(item_open_flag: 1).page(params[:page]).per(PER).neworder
      @items_array.push(items_subcate) #押されたpaginateのsubcateogryのitemのみ格納
    else #tab1~3のpaginateが押されない (他のタブを見ている、tab1-3の最初の状態を見ている => 1ページ目)
      @categories.each do |category|
        @items_array = Array.new()
        @subcategories = category.subcategories
        @subcategories.each do |subcategory|
          items_subcate = @user.items.where(subcategory_id: subcategory.id).where(item_open_flag: 1).page(1).per(PER).neworder
          @items_array.push(items_subcate)
        end
        @item_cate_sort.store(category.id, @items_array)   #  {1(category)=>[[(sub1のitem)],[(sub2のitem)]..],2(category)=>[[sub3],[sbu4]..],.. }が作られる
      end
    end  #if end

    if params[:tab] == "other_murmurs"
      @murmurs = @user.murmurs.page(params[:page]).per(PER).neworder
    else
      @murmurs = @user.murmurs.page(1).per(PER).neworder
    end
    respond_to do |format|
      format.html
      format.js
    end
  end # show end

  private

  # strong_parameter :public_name, :area,
  def user_params
    params.require(:user).permit(:public_name, :area1, :area2, :senior, :middle, :junior, :infant, :avatar, :profile)
  end
end
