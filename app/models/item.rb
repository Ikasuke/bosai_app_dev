# encoding: utf-8
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
#  subcategory_id       :bigint(8)
#

class Item < ApplicationRecord
  has_attached_file :picture,
                    styles: {medium: "300x300>", thumb: "100x100>"},
                    default_url: "http://localhost:3000/noimage.jpg"

  ## validation
  validates_attachment_content_type :picture, content_type: ["image/jpeg", "image/gif", "image/png"]
  #item_nameは空でないこと、長さが50文字以内であること
  validates :item_name, presence: true, length: {maximum: 50}
  #category_idは空でないこと=>必須選択
  validates :category_id, presence: true
  #item_volumeは長さが50文字以内であること
  validates :item_volume, length: {maximum: 50}
  #item_expiry 特になし
  #item_public_memo 10000文字以内であること
  validates :item_public_memo, length: {maximum: 10000}
  #item_private_memo 10000文字以内であること
  validates :item_private_memo, length: {maximum: 10000}

  ##enum
  enum item_open_flag: {公開する: true, 公開しない: false}

  ##scope　　最新の登録が前に来るように
  scope :neworder, -> { order(created_at: :desc) }

  # #リレーション
  # user
  belongs_to :user
  # category
  belongs_to :category
  # subcategory
  belongs_to :subcategory
  # comments
  has_many :comments, dependent: :destroy
  # likeitems
  has_many :likeitems, dependent: :destroy

  ## search メソッド
  def self.search(search)
    if search
      Item.where(["item_name LIKE ?", "%#{search}%"]).where(item_open_flag: 1)
    else
      Item.where(item_open_flag: 1)
    end
  end

  # deadlineメソッド　グッズの消費期限が所定なものをだす
  def self.deadline(date1, date2)
    if date1
      if date2
        from = Time.now + 24 * 3600 * date1
        to = Time.now + 24 * 3600 * date2
        Item.where(item_expiry: from..to)
      else
        from = Time.now + 24 * 3600 * date1
        Item.where("item_expiry >= ?", from)
      end
    else
      if date2
        to = Time.now + 24 * 3600 * date2
        Item.where("item_expiry <= ?", to)
      end
    end
  end
  # scope　commentsがunread なものを探す
  scope :unread, -> {
          joins(:comments).where("comments.read = ?", 0)
        }

  #scope likeitem のuser_idが特定のものを探す
  scope :like_item, -> user_id {
          joins(:likeitems).where("likeitems.user_id = ?", user_id).where(item_open_flag: 1)
        }
end #class end
