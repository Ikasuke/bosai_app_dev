# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string(255)
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string(255)      default(""), not null
#  role                   :integer          default("user"), not null
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  public_name            :string(255)      default(""), not null
#  area1                  :string(255)      default(""), not null
#  area2                  :string(255)
#  family                 :string(255)
#

class User < ApplicationRecord
  # #devise
  # Include default devise modules. Others available are:
  # :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :confirmable, :lockable, :timeoutable

  has_attached_file :avatar,
                    styles: { medium: '300x300>', thumb: '100x100>' },
                    default_url: 'http://localhost:3000/rocket.jpg'

  ## validation
  validates_attachment_content_type :avatar, content_type: ['image/jpeg', 'image/gif', 'image/png']
  validates :name, presence: true # ,uniquness: { case_sensitive: false}
  validates_format_of :name, with: /^[a-zA-Z0-9_¥.]*$/, multiline: true
  validate :validate_name

  def validate_name
    errors.add(:name, :invalid) if User.where(email: name).exists?
  end

  ## ログイン属性を追加する
  # ゲッター
  def login
    @login || name || email
  end

  # セッター
  attr_writer :login
  # def login=(value)
  #  @login = value
  # end

  ## ログイン時のアクションを変更する name or emailでログインできる
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    conditions[:email]&.downcase!
    login = conditions.delete(:login)

    where(conditions.to_hash).where(
      ['lower(name) = :value OR lower(email) = :value',
       { value: login.downcase }]
    ).first
  end

  # #管理者権限
  enum role: { user: 0, admin: 1 }

  # #リレーション
  # items
  has_many :items, dependent: :destroy
  # comments
  has_many :comments, dependent: :destroy
  # remindmails
  has_many :remindmails, dependent: :destroy
  # murmurs
  has_many :murmurs, dependent: :destroy
  # favorites
  # favoriteをuserと２つ　つなげるしくみ
  has_many :favorites_of_from_user, class_name: 'Favorite', foreign_key: 'from_user_id', dependent: :destroy
  has_many :favorites_of_to_user, class_name: 'Favorite', foreign_key: 'to_user_id', dependent: :destroy
  # 自己結合するしくみ
  has_many :friends_of_from_user, through: :favorites_of_from_user, source: 'to_user'
  has_many :friends_of_to_user, through: :favorites_of_to_user, source: 'from_user'
  # likeitems
  has_many :likeitems, dependent: :destroy
end
