# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id            :bigint(8)        not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  category_name :string(255)      default(""), not null
#

class Category < ApplicationRecord
  # #リレーション
  # items
  has_many :items, dependent: :destroy
end
