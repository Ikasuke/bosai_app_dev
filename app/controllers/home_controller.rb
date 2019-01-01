# encoding: utf-8
# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_admin_user!, only: [:adminhome]

  # kaminari paging 一ページあたりの表示数
  PER = 8  # tab1
  PER_2 = 4  # tab2

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
    # コメント未読数を表示させる
    @all_unread_counts = 0
    @items.each.each do |item|
      item.comments.each do |comment|
        if comment.read == "unread"
          @all_unread_counts = @all_unread_counts + 1
        end
      end
    end
    ## カテゴリー別tab(tab2)
    @categories = Category.all
    @items_array = Array.new()

    if params[:tab] == "tab2" #この時、tab2のpaginateが押された
      @categories.each do |category| #押されたpaginateのカテゴリだけpaginate
        if params[:category_id] == "#{category.id}"
          items_c = current_user.items.where(category_id: category.id).page(params[:page]).per(PER_2).neworder
          @items_array.push(items_c)
        end
      end
    else #tab2のpaginateが押されない (他のタブを見ている、tab2の最初の状態を見ている => 1ページ目)
      @categories.each do |category|
        items_c = current_user.items.where(category_id: category.id).page(1).per(PER_2).neworder
        @items_array.push(items_c)
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
end   #class end
