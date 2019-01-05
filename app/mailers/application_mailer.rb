# encoding: utf-8
# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "防災ストッカー <info@hoge.com>"  # <info@hoge.com>を入れないと555 5.5.2errorになる
  #reply_to: "info@hoge.com"
  layout "mailer"
end
