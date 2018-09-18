# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id                :bigint(8)        not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  item_name         :string(255)      default(""), not null
#  item_volume       :string(255)      default(""), not null
#  item_expiry       :datetime
#  item_picture_file :string(255)
#  item_public_memo  :text(65535)
#  item_private_memo :text(65535)
#  item_open_flag    :boolean          default(TRUE), not null
#  user_id           :bigint(8)
#  category_id       :bigint(8)
#

class Item < ApplicationRecord
  # #リレーション
  # user
  belongs_to :user
  # category
  belongs_to :category
  # comments
  has_many :comments, dependent: :destroy
  # likeitems
  has_many :likeitems, dependent: :destroy
end
