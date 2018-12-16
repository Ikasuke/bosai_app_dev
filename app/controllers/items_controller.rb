# encoding: utf-8
class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :destroy, :show]

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
      render :layout => "item_new.html.erb"
    else
      redirect_to item_url     #自分のじゃないので、showへ
    end
  end #edit end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    respond_to do |format|
      if @item.save
        format.html { redirect_to home_url, notice: "item was successfully created." }
        #format.json { render :show, status: :created, location: @category }
      else
        format.html { redirect_to home_url }
        #format.json { render json: @category.errors, status: :unprocessable_entity }
      end  #if end
    end    # respond_to end
  end # create end

  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to home_url, notice: " item was successfully updated." }
        #format.json { render :show, status: :ok, location: @to_do_item }
      else
        format.html { redirect_to home_url }
        #format.json { render json: @to_do_item.errors, status: :unprocessable_entity }
      end
    end
  end #update end

  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to home_url, notice: "To do item was successfully destroyed." }
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
    # # item情報
    @items = Item.search(params[:search])

    @like_hash = Likeitem.where(user_id: current_user.id).pluck(:id, :item_id).to_h
    ## いいねしたアイテムを表示する準備
    @item_like = Array.new()
    @user.likeitems.each do |likeitem|
      if likeitem.item.item_open_flag == "公開する"
        @item_like.push(likeitem.item)
      end
    end
  end

  def reading_table #検索結果を表示させる

    #グッズから探す場合
    if params[:search]
      @items = Item.search(params[:search])
      @tab = "tab1"
    end

    #カテゴリから探す場合
    if params[:category_id]
      @items = Item.where(category_id: params[:category_id]).where(item_open_flag: 1)
      @tab = "tab2"
    end

    @like_hash = Likeitem.where(user_id: current_user.id).pluck(:id, :item_id).to_h

    respond_to do |format|
      format.js    # reading_table.js.erbを処理させる
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def item_params
    params.require(:item).permit(:item_name, :picture, :item_volume, :item_expiry, :item_public_memo, :item_private_memo, :item_open_flag, :category_id)
  end
end # class end
