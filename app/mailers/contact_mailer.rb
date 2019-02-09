# encoding: utf-8
class ContactMailer < ActionMailer::Base
  def send_mailer(contact)
    @contact = contact
    mail(
      from: @contact.contact_email,
      to: Rails.application.credentials.dig(:production, :SMTP_EMAIL),
      subject: "お問い合わせ通知",
    )
  end

  layout "mailer"
end
