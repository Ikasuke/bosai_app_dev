# encoding: utf-8
class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :destroy, :show]
  before_action :detect_browser
  PER = 10

  def show #他人のも観れる
    @like_hash = Likeitem.where(user_id: current_user.id).pluck(:id, :item_id).to_h
  end

  def new
    ## @categoresを準備

    categories = Category.all
    category_selects = Array.new()      # 空
    categories.each do |category|
      category_select = [category.category_name, category.id]
      category_selects.push(category_select)
    end
    @category_selects = category_selects

    @subcategories = {}

    categories.each do |category|
      @subcate = Array.new()
      category.subcategories.each do |sub_c|
        @subcate.push([sub_c.subcategory_name, sub_c.id])
      end
      @subcategories.store(category.id, @subcate)
    end
    @volume_selects = Array.new()
    101.times do |t|
      @volume_selects.push("#{t}")
    end
    if params[:i_error_messages].nil?
      @i_error_details = {key: "no_error"}   #ダミーのkeyとvalueを入れておく エラー防止
    else
      #validationのエラー表示用
      @i_error_messages = params[:i_error_messages]   # エラーのメッセージ
      @i_error_details = params[:i_error_details]     #エラーが表示された部分が格納
    end
    render :layout => "item_new.html.erb"
  end

  def edit #自分のitemしか編集できないようにする
    if @item.user == current_user
      ## @categoresを準備
      categories = Category.all
      category_selects = Array.new()      # 空
      categories.each do |category|
        category_select = [category.category_name, category.id]
        category_selects.push(category_select)
      end
      @category_selects = category_selects
      @subcategories = {}
      categories.each do |category|
        @subcate = Array.new()
        category.subcategories.each do |sub_c|
          @subcate.push([sub_c.subcategory_name, sub_c.id])
        end
        @subcategories.store(category.id, @subcate)
      end
      @volume_selects = Array.new()
      101.times do |t|
        @volume_selects.push("#{t}")
      end
      if params[:i_error_messages].nil?
        @i_error_details = {key: "no_error"}   #ダミーのkeyとvalueを入れておく エラー防止
      else
        #validationのエラー表示用
        @i_error_messages = params[:i_error_messages]   # エラーのメッセージ
        @i_error_details = params[:i_error_details]     #エラーが表示された部分が格納
      end
      if @item.item_expiry.nil?
        @expiry_d = [Date.today.strftime("%Y").to_i, Date.today.strftime("%m").to_i, Date.today.strftime("%d").to_i]
      else
        @e_check = "check_ok"
        @expiry_d = [@item.item_expiry.strftime("%Y").to_i, @item.item_expiry.strftime("%m").to_i, @item.item_expiry.strftime("%d").to_i]
      end

      render :layout => "item_new.html.erb"
    else
      redirect_to item_url     #自分のじゃないので、showへ
    end
  end #edit end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if params[:item]["subcategory_id"].blank?
    else
      @item.category_id = Subcategory.find(params[:item]["subcategory_id"]).category.id
    end

    # smart用の処理
    if params[:expiry_check].nil?
      #普通
    else # smart用
      if params[:expiry_check]["check_val"] == "0"
      else
        expiry_string = params[:item]["expiry_parts(1i)"].to_s + "/" + params[:item]["expiry_parts(2i)"].to_s + "/" + params[:item]["expiry_parts(3i)"].to_s
        item_expiry = expiry_string.to_datetime
        @item.item_expiry = item_expiry
      end
    end
    respond_to do |format|
      if @item.save
        format.html { redirect_to home_url, notice: "防災アイテムを正常に登録できました" }
        #format.json { render :show, status: :created, location: @category }
      else
        format.html { redirect_to new_item_path(i_error_messages: @item.errors.messages, i_error_details: @item.errors.details), flash: {error: "作成できませんでした"} }
        #format.json { render json: @category.errors, status: :unprocessable_entity }
      end  #if end
    end    # respond_to end
  end # create end

  def update
    if params[:item]["subcategory_id"].blank?
    else
      @item.category_id = Subcategory.find(params[:item]["subcategory_id"]).category.id
    end
    # smart用の処理
    if params[:expiry_check].nil?
      #普通
    else # smart用
      if params[:expiry_check]["check_val"] == "0"
        @item.item_expiry = nil
      else
        expiry_string = params[:item]["expiry_parts(1i)"].to_s + "/" + params[:item]["expiry_parts(2i)"].to_s + "/" + params[:item]["expiry_parts(3i)"].to_s
        item_expiry = expiry_string.to_datetime
        @item.item_expiry = item_expiry  ##expiryの更新部分
      end
    end
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to home_url, notice: " 更新できました" }
        #format.json { render :show, status: :ok, location: @to_do_item }
      else
        format.html { redirect_to edit_item_path(i_error_messages: @item.errors.messages, i_error_details: @item.errors.details), flash: {error: "更新できませんでした"} }
        #format.json { render json: @to_do_item.errors, status: :unprocessable_entity }
      end
    end
  end #update end

  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to home_url, notice: "削除しました." }
      #format.json { head :no_content }
    end
  end # destroy end

  ##

  def index #みんなのグッズが見れるページ
    # #ログインユーザー情報
    @user = current_user
    #リマインドメールを表示するために登録されているものを呼び出す。なければ表示しない
    remindmails = current_user.remindmails
    # グッズを表示するために登録されているものを呼び出す。なければ表示しない
    if remindmails.empty?
      # ないので何もしない
    else
      @remindmails = remindmails
    end
    # # @categoresを準備
    categories = Category.all
    category_selects = Array.new()      # 空
    categories.each do |category|
      category_select = [category.category_name, category.id]
      category_selects.push(category_select)
    end
    @category_selects = category_selects
    # # item情報 tab1=> params[:search] tab2=> params[:category_id]
    if params[:tab].nil?
      @items = Item.search(params[:search]).page(params[:page]).per(PER).neworder
    else
      if params[:tab] == "tab1"
        @items = Item.search(params[:search]).page(params[:page]).per(PER).neworder
      end
      if params[:tab] == "tab2"
        if params[:category_id].nil?
          @items = Item.search(params[:search]).page(params[:page]).per(PER).neworder
        else
          @items = Item.where(category_id: params[:category_id]).where(item_open_flag: 1).page(params[:page]).per(PER).neworder
        end
      end
    end
    @like_hash = Likeitem.where(user_id: current_user.id).pluck(:id, :item_id).to_h
    ## いいねしたアイテムを表示する準備
    if params[:tab] == "tab3"
      @items_like = Item.like_item(current_user.id).page(params[:page]).per(PER).neworder
    else
      @items_like = Item.like_item(current_user.id).page(1).per(PER).neworder
    end
    respond_to do |format|   ## 一応jsを用意しているが、写真のプレビューが表示されない（jsが発火しない）ため全てlocalnにしてある
      format.html
      format.js
    end
  end # index end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def item_params
    params.require(:item).permit(:item_name, :picture, :item_volume, :item_expiry, :item_public_memo, :item_private_memo, :item_open_flag, :subcategory_id)
  end

  def detect_browser
    if browser.device.mobile? #browser.chrome? #
      request.variant = :smart
    end
  end
end # class end
