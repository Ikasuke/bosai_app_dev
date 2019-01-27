# encoding: utf-8
# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_admin_user!, only: [:adminhome]
  before_action :detect_browser
  # kaminari paging 一ページあたりの表示数
  PER = 8  # tab1
  PER_2 = 4  # tab2
  PER_3 = 4  # tab5

  def index
    @user = current_user
    # リマインドメールを表示するために登録されているものを呼び出す。なければ表示しない
    remindmails = current_user.remindmails
    if remindmails.empty?
      # ないので何もしない
    else
      @remindmails = remindmails
    end
    ## tab1
    # グッズを表示するために登録されているものを呼び出す。なければ表示しない
    @items = current_user.items.page(params[:page]).per(PER).neworder

    ## カテゴリー別tab(tab2)
    @categories = Category.all
    @item_cate_sort = {}

    if params[:tab] == "tab_category" #この時、tab2~4のpaginateが押された
      @items_array = Array.new()
      #押されたpaginateのカテゴリだけpaginate
      items_subcate = current_user.items.where(subcategory_id: params[:subcategory_id].to_i).page(params[:page]).per(PER_2).neworder
      @items_array.push(items_subcate) #押されたpaginateのsubcateogryのitemのみ格納
    else #tab2~4のpaginateが押されない (他のタブを見ている、tab2=4の最初の状態を見ている => 1ページ目)
      @categories.each do |category|
        @items_array = Array.new()
        @subcategories = category.subcategories
        @subcategories.each do |subcategory|
          items_subcate = current_user.items.where(subcategory_id: subcategory.id).page(1).per(PER_2).neworder
          @items_array.push(items_subcate)
        end
        @item_cate_sort.store(category.id, @items_array)   #  {1(category)=>[[(sub1のitem)],[(sub2のitem)]..],2(category)=>[[sub3],[sbu4]..],.. }が作られる
      end
    end  #if end

    ##tab5
    @items_expiry_array = Array.new()
    if params[:tab] == "tab5" #この時、tab5のpaginateが押された
      if params[:dead] == "0"
        @items_expiry_array[0] = @user.items.deadline(nil, -1).page(params[:page]).per(PER_3).neworder
      end
      if params[:dead] == "1"
        @items_expiry_array[1] = @user.items.deadline(0, 7).page(params[:page]).per(PER_3).neworder
      end
      if params[:dead] == "2"
        @items_expiry_array[2] = @user.items.deadline(8, 30).page(params[:page]).per(PER_3).neworder
      end
      if params[:dead] == "3"
        @items_expiry_array[3] = @user.items.deadline(31, 90).page(params[:page]).per(PER_3).neworder
      end
    else #tab5のpaginateが押されない (他のタブを見ている、tab5の最初の状態を見ている => 1ページ目)
      @items_expiry_array[0] = @user.items.deadline(nil, -1).page(1).per(PER_3).neworder
      @items_expiry_array[1] = @user.items.deadline(0, 7).page(1).per(PER_3).neworder
      @items_expiry_array[2] = @user.items.deadline(8, 30).page(1).per(PER_3).neworder
      @items_expiry_array[3] = @user.items.deadline(31, 90).page(1).per(PER_3).neworder
    end
    # tab6
    @items_unread = current_user.items.unread.uniq
    # コメント未読数を表示させる
    @all_unread_counts = 0
    @items_unread.each.each do |item|
      item.comments.each do |comment|
        if comment.read == "unread"
          @all_unread_counts = @all_unread_counts + 1
        end
      end
    end

    respond_to do |format|
      format.html
      format.js
    end
  end #index end

  def adminhome
    @categories = Category.all

    render :layout => "admin.html.erb"
  end

  private

  def detect_browser
    if browser.device.mobile? #browser.chrome? #
      request.variant = :smart
    end
  end
end   #class end
