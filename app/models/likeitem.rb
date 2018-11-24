# frozen_string_literal: true
# == Schema Information
#
# Table name: likeitems
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint(8)
#  item_id    :bigint(8)
#

class Likeitem < ApplicationRecord
  # #リレーション
  # user
  belongs_to :user
  # item
  belongs_to :item

  ## validation
  validates_uniqueness_of :item_id, scope: :user_id


end
