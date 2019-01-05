# frozen_string_literal: true

# == Schema Information
#
# Table name: remindmails
#
#  id           :bigint(8)        not null, primary key
#  remind_email :string(255)      default(""), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint(8)
#

class Remindmail < ApplicationRecord
  ##validation
  # remind_email は空でないこと mailの形式であること 一人５個まで=>controllerで表現
  VALID_EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\z/
  validates :remind_email, presence: true,
                           format: {with: VALID_EMAIL_REGEX}
  # #リレーション
  # user
  belongs_to :user
end
