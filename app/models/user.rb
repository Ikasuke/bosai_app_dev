# frozen_string_literal: true

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
