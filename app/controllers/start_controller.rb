# frozen_string_literal: true

class StartController < ApplicationController
  skip_before_action :authenticate_user!
  layout "startpage"

  def index
    @user = if current_user.nil?
              User.new
            else
              current_user
            end
  end

  def start_info
  end
end
