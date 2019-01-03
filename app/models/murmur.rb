# frozen_string_literal: true

# == Schema Information
#
# Table name: murmurs
#
#  id            :bigint(8)        not null, primary key
#  murmur_detail :text(65535)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint(8)
#

class Murmur < ApplicationRecord
  # #リレーション
  # user
  belongs_to :user

  ##scope　　最新の登録が前に来るように
  scope :neworder, -> { order(created_at: :desc) }
end
