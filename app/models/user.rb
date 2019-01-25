# encoding: utf-8
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
#  profile                :text(65535)
#  senior                 :integer          default(0), not null
#  middle                 :integer          default(0), not null
#  junior                 :integer          default(0), not null
#  infant                 :integer          default(0), not null
#

class User < ApplicationRecord
  ## devise
  # Include default devise modules. Others available are:
  # :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :confirmable, :lockable, :timeoutable

  has_attached_file :avatar,
                    styles: {medium: "300x300>", thumb: "100x100>"},
                    default_url: "http://localhost:3000/rocket.jpg"

  ## validation
  validates_attachment_content_type :avatar, content_type: ["image/jpeg", "image/gif", "image/png"]
  # nameは存在していること、ユニークであること、ローマ字であること、Eメールと名前が同一でないこと、25文字以内であること
  validates :name, presence: true, uniqueness: {case_sensitive: false}, length: {maximum: 25} # 大文字小文字の差を無視して同一を禁止
  validates_format_of :name, with: /^[a-zA-Z0-9_¥.]*$/, multiline: true
  validate :validate_name
  # emailは存在していること、ユニークであること  config/initializers/devise.rb に (config.email_regexp = /\A[^@\s]+@[^@\s]+\z/)が書いてある
  validates :email,
            presence: true,
            uniqueness: true,
            length: {maximum: 255, too_log: "長すぎます"}
  # passwordは6文字以上であること
  #=>config/initializers/devise.rb に書いてある
  # public_nameは30文字以内であること
  validates :public_name,
            length: {maximum: 30, too_log: "長すぎます。ニックネーム"}

  # profileは5000文字以内であること
  validates :profile,
            length: {maximum: 5000, too_log: "長すぎます。自己紹介"}

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
      ["lower(name) = :value OR lower(email) = :value",
       {value: login.downcase}]
    ).first
  end

  # #管理者権限
  enum role: {user: 0, admin: 1}

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
  has_many :favorites_of_from_user, class_name: "Favorite", foreign_key: "from_user_id", dependent: :destroy
  has_many :favorites_of_to_user, class_name: "Favorite", foreign_key: "to_user_id", dependent: :destroy
  # 自己結合するしくみ
  has_many :friends_of_from_user, through: :favorites_of_from_user, source: "to_user"
  has_many :friends_of_to_user, through: :favorites_of_to_user, source: "from_user"
  # likeitems
  has_many :likeitems, dependent: :destroy

  # Sidekiq
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  ## onlyuser メソッド  家族構成が一人の人を出力
  def self.onlyuser
    User.where("(senior + middle + junior+ infant= ?)", 1)
  end
  ## senior メソッド  家族に65歳以上の方がいる人を出力
  def self.senior
    User.where("(senior > ?)", 0)
  end
  ## child メソッド  家族に子供（0-18）がいる人を出力
  def self.child
    User.where("(junior + infant > ?)", 0)
  end
  ## infant メソッド  家族に未就学児がいる人を出力
  def self.infant
    User.where("(infant > ?)", 0)
  end
end
