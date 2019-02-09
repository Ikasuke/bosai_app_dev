# encoding: utf-8
class Contact
  include ActiveModel::Model

  attr_accessor :contact_name, :contact_email, :message

  VALID_EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\z/
  validates :contact_name, presence: true
  validates :contact_email,
            presence: true,
            format: {with: VALID_EMAIL_REGEX}

  validates :message,
            presence: true,
            length: {maximum: 5000, too_log: "長すぎます。メッセージ"}
end
