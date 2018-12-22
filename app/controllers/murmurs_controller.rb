# encoding: utf-8
class MurmursController < ApplicationController
  def index

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
    @allusers = User.all
    @murmurs = Murmur.all
    # いいねが多いアイテムを表示させる
    @max_items = {}
    @allusers.each do |a_user|
      if a_user.items.empty?
        @max_item = nil # グッズを持っていないユーザーにはnil
      else
        a_user.items.each_with_index do |item, index|
          if index == 0
            @max = -1
            @max_item = nil   #とりあえずnilが入る
          end
          if item.item_open_flag == "公開する"
            if @max < item.likeitems.count
              @max = item.likeitems.count
              @max_item = item   # 公開しているものがあれば、その中でいいねが多いものが入る
            end
          end #if end
        end  # a_user.each end
      end  # if nil? end
      @max_items.store(a_user.id, @max_item)  #全て非公開もしくは何もアイテムを登録していないと、nilが入る
    end # alluser.each end
    #  item.id item.likeitems.count

    @favorite_hash = Favorite.where(from_user_id: current_user.id).pluck(:id, :to_user_id).to_h   #ログインユーザーがお気に入りしたユーザーのデータ

    ## お気に入りした人を表示する準備
    @favorite_users = Array.new()
    @user.favorites_of_from_user.each do |favorite|
      @favorite_users.push(favorite.to_user)
    end
  end   # index end

  def create
    @murmur = Murmur.new(murmur_params)
    @murmur.user_id = current_user.id
    respond_to do |format|
      if @murmur.save
        format.html { redirect_to murmurs_url, notice: "murmur was successfully created." }
        #format.json { render :show, status: :created, location: @category }
      else
        format.html { redirect_to murmurs_url }
        #format.json { render json: @category.errors, status: :unprocessable_entity }
      end  #if end
    end    # respond_to end
  end #create end

  def region
    @max_items = {}
    if params[:area2] == "全地域"
      @allusers = User.where(area1: params[:area1])
    else
      @allusers = User.where(area1: params[:area1], area2: params[:area2])
    end #if end
    @allusers.each do |a_user|
      a_user.items.each_with_index do |item, index|
        if index == 0
          @max = item.likeitems.count
          @max_item = item
        end
        if @max < item.likeitems.count
          @max = item.likeitems.count
          @max_item = item
        end
      end  # a_user.each end
      @max_items.store(a_user.id, @max_item)
    end

    @favorite_hash = Favorite.where(from_user_id: current_user.id).pluck(:id, :to_user_id).to_h   #ログインユーザーがお気に入りしたユーザーのデータ

    respond_to do |format|
      format.js
    end
  end #region end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def murmur_params
    params.require(:murmur).permit(:murmur_detail)
  end
end # class end
