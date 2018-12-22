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
  end #index end

  def adminhome
    @categories = Category.all

    render :layout => "admin.html.erb"
  end
end   #class end
