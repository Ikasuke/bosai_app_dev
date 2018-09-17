# frozen_string_literal: true

# == Schema Information
#
# Table name: favorites
#
#  id           :bigint(8)        not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  from_user_id :bigint(8)
#  to_user_id   :bigint(8)
#

class Favorite < ApplicationRecord
  # favoriteをuserと２つ　つなげるしくみ
  belongs_to :from_user, class_name: 'User', foreign_key: 'from_user_id'
  belongs_to :to_user, class_name: 'User', foreign_key: 'to_user_id'
end
