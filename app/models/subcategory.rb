# frozen_string_literal: true
# == Schema Information
#
# Table name: subcategories
#
#  id               :bigint(8)        not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  subcategory_name :string(255)      default(""), not null
#  category_id      :bigint(8)
#

class Subcategory < ApplicationRecord
  # #リレーション
  # items
  has_many :items, dependent: :destroy
  #category
  belongs_to :category
end
