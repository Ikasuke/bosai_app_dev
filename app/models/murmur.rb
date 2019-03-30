# frozen_string_literal: true
# == Schema Information
#
# Table name: murmurs
#
#  id                          :bigint(8)        not null, primary key
#  murmur_detail               :text(65535)      not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  user_id                     :bigint(8)
#  murmur_picture_file_name    :string(255)
#  murmur_picture_content_type :string(255)
#  murmur_picture_file_size    :integer
#  murmur_picture_updated_at   :datetime
#

class Murmur < ApplicationRecord
  #paperclip
  has_attached_file :murmur_picture,
                    styles: {medium: "300x300>", thumb: "100x100>"},
                    convert_options: {all: "-strip"},
                    default_url: "/noimage.jpg"

  # #リレーション
  # user
  belongs_to :user
  ## validation
  validates_attachment_content_type :murmur_picture, content_type: ["image/jpeg", "image/gif", "image/png"]
  #validate 空でないこと、長さが3000以内であること
  validates :murmur_detail, presence: true, length: {maximum: 3000}
  ##scope　　最新の登録が前に来るように
  scope :neworder, -> { order(created_at: :desc) }
end
