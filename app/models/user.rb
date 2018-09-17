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
#  role                   :integer          default(0), not null
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :confirmable, :lockable, :timeoutable

  # favoriteをuserと２つ　つなげるしくみ
  has_many :favorites_of_from_user, class_name: 'Favorite', foreign_key: 'from_user_id', dependent: :destroy
  has_many :favorites_of_to_user, class_name: 'Favorite', foreign_key: 'to_user_id', dependent: :destroy
  # 自己結合するしくみ
  has_many :friends_of_from_user, through: :favorites_of_from_user, source: 'to_user'
  has_many :friends_of_to_user, through: :favorites_of_to_user, source: 'from_user'
end
