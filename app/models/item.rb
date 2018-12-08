# frozen_string_literal: true
# == Schema Information
#
# Table name: items
#
#  id                   :bigint(8)        not null, primary key
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  item_name            :string(255)      default(""), not null
#  item_volume          :string(255)      default(""), not null
#  item_expiry          :datetime
#  item_public_memo     :text(65535)
#  item_private_memo    :text(65535)
#  item_open_flag       :boolean          default("公開する"), not null
#  user_id              :bigint(8)
#  category_id          :bigint(8)
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

class Item < ApplicationRecord


  has_attached_file :picture,
  styles: { medium: '300x300>', thumb: '100x100>' },
  default_url: 'http://localhost:3000/noimage.jpg'

  ## validation
  validates_attachment_content_type :picture, content_type: ['image/jpeg', 'image/gif', 'image/png']
  validates :item_name, presence: true 
  validates :category_id, presence: true
  
 ##enum
  enum item_open_flag: { 公開する: true, 公開しない: false}

  # #リレーション
  # user
  belongs_to :user
  # category
  belongs_to :category
  # comments
  has_many :comments, dependent: :destroy
  # likeitems
  has_many :likeitems, dependent: :destroy

## search メソッド
def self.search(search)
  if search
  Item.where(['item_name LIKE ?', "%#{search}%"]).where(item_open_flag: 1)
  else
  Item.where(item_open_flag: 1)
  end
end




end
