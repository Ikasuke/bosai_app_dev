# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @user = current_user
      # リマインドメールを表示するために登録されているものを呼び出す。なければ表示しない
    remindmails = current_user.remindmails
     if remindmails.empty? then
        # ないので何もしない
     else
          @remindmails = remindmails
     end
  end
end
