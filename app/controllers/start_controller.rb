# frozen_string_literal: true

class StartController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @user = if current_user.nil?
              User.new
            else
              current_user
            end
  end

  def test
  end
end
