# encoding: utf-8
class MurmursController < ApplicationController
  PER = 4

  def index
    ## sidebar
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
    ## main つながり部
    # 最近発信した順に全てのユーザーを並べる
    @users_sort_late = {}
    User.all.each do |user|
      latest = user.murmurs.maximum(:created_at)
      if latest.nil?
        @users_sort_late.store(user, 0)
      else
        @users_sort_late.store(user, latest.to_i)
      end
    end
    @users_sort_late = @users_sort_late.sort_by { |k, v| v }.reverse.to_h  #発信した順に並んだハッシュ{user, 発信日}
    #tab1  最近発信した順に並べる
    if params[:area1].nil?
      @area = "日本全域"
      @allusers = Kaminari.paginate_array(@users_sort_late.keys).page(params[:page]).per(PER)
    else # params[:area1]がある
      @area = "#{params[:area1]}/#{params[:area2]}"
      if params[:area2] == "全地域"
        @users_area1 = Array.new()
        @users_sort_late.keys.each do |user|
          if user.area1 == params[:area1]
            @users_area1.push(user)
          end
        end
        @allusers = Kaminari.paginate_array(@users_area1).page(params[:page]).per(PER)
      else
        @users_area2 = Array.new()
        @users_sort_late.keys.each do |user|
          if user.area1 == params[:area1] && user.area2 == params[:area2]
            @users_area2.push(user)
          end
        end
        @allusers = Kaminari.paginate_array(@users_area2).page(params[:page]).per(PER)
      end #if end
    end
    # いいねが多いアイテムを表示させる　最新のつぶやきを表示させる
    @max_items = {}
    @new_murmurs = {}
    @allusers.each do |a_user|
      ## いいねが多いアイテムを入れる処理
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
      ##最新の呟きを入れる処理
      if a_user.murmurs.empty?
        @new_murmur = nil
      else
        @new_murmur = a_user.murmurs.last
      end
      @new_murmurs.store(a_user.id, @new_murmur)
    end # alluser.each end

    @favorite_hash = Favorite.where(from_user_id: current_user.id).pluck(:id, :to_user_id).to_h   #ログインユーザーがお気に入りしたユーザーのデータ

    # tab2 お気に入りした人を表示する準備 最近発信した順に並んでいる
    @favorites = Array.new()

    @users_sort_late.keys.each do |user_s|
      user_s.favorites_of_to_user.each do |favorite|
        if favorite.from_user == current_user
          @favorites.push(favorite.to_user)
        end
      end
    end
    if params[:tab] == "tab2"
      @favorite_users = Kaminari.paginate_array(@favorites).page(params[:page]).per(PER)
    else
      @favorite_users = Kaminari.paginate_array(@favorites).page(1).per(PER)
    end

    #tab3 自らの発信をみる
    @murmurs = @user.murmurs.page(params[:page]).per(PER).order(created_at: :desc)
    @all_murmurs_count = @user.murmurs.count
    respond_to do |format|
      format.html
      format.js
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

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def murmur_params
    params.require(:murmur).permit(:murmur_detail)
  end
end # class end
