# encoding: utf-8
# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_admin_user!, only: [:adminhome]

  def index
    @user = current_user
    # リマインドメールを表示するために登録されているものを呼び出す。なければ表示しない
    remindmails = current_user.remindmails
    # グッズを表示するために登録されているものを呼び出す。なければ表示しない
    items = current_user.items.neworder
    if remindmails.empty?
      # ないので何もしない
    else
      @remindmails = remindmails
    end

    @items = items
    @categories = Category.all

    @all_unread_counts = 0
    @items.each.each do |item|
      item.comments.each do |comment|
        if comment.read == "unread"
          @all_unread_counts = @all_unread_counts + 1
        end
      end
    end
  end #index end

  def adminhome
    @categories = Category.all

    render :layout => "admin.html.erb"
  end
end   #class end
