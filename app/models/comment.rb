# frozen_string_literal: true
# == Schema Information
#
# Table name: comments
#
#  id                           :bigint(8)        not null, primary key
#  comment_detail               :text(65535)      not null
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  item_id                      :bigint(8)
#  user_id                      :bigint(8)
#  read                         :integer          default("unread"), not null
#  comment_picture_file_name    :string(255)
#  comment_picture_content_type :string(255)
#  comment_picture_file_size    :integer
#  comment_picture_updated_at   :datetime
#

class Comment < ApplicationRecord
  #paperclip
  has_attached_file :comment_picture,
                    styles: {medium: "300x300>", thumb: "100x100>"},
                    convert_options: {all: "-strip"},
                    default_url: "/noimage.jpg"

  ## validation
  #item_nameは空でないこと、長さが1000文字以内であること
  validates :comment_detail, presence: true, length: {maximum: 1000}
  ## validation
  validates_attachment_content_type :comment_picture, content_type: ["image/jpeg", "image/gif", "image/png"]
  ## enum 既読かどうか
  enum read: {unread: 0, already: 1}

  # #リレーション
  # user
  belongs_to :user
  # item
  belongs_to :item
end
