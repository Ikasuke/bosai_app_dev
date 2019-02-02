# encoding: utf-8
# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :detect_browser
  rescue_from SecurityError do |_exception|
    redirect_to root_url, notice: "アドミン画面へのアクセス権限がありません"
  end

  protected

  # #strong_parameter
  def configure_permitted_parameters
    added_attrs = %i[name email password password_confirmation remember_me avatar]

    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end

  # #権限の制御

  def authenticate_admin_user!
    raise SecurityError unless current_user.try(:admin?)
  end

  def detect_browser
    if browser.device.mobile? #browser.chrome? #
      request.variant = :smart
    end
  end
end
