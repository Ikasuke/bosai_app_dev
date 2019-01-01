# frozen_string_literal: true
# == Schema Information
#
# Table name: comments
#
#  id             :bigint(8)        not null, primary key
#  comment_detail :text(65535)      not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  item_id        :bigint(8)
#  user_id        :bigint(8)
#  read           :integer          default("unread"), not null
#

class Comment < ApplicationRecord

  ## validation
  #item_nameは空でないこと、長さが1000文字以内であること
  validates :comment_detail, presence: true, length: {maximum: 1000}

  ## enum 既読かどうか
  enum read: {unread: 0, already: 1}

  # #リレーション
  # user
  belongs_to :user
  # item
  belongs_to :item
end
