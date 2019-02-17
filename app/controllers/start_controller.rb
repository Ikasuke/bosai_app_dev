# frozen_string_literal: true

class StartController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @user = if current_user.nil?
              User.new
            else
              current_user
            end
    if browser.device.mobile? #browser.chrome? #
    else
      render :layout => "startpage"
    end
  end

  def start_info
  end

  def admin_info
    render :layout => "startpage"
  end
end
