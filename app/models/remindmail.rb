# frozen_string_literal: true

# == Schema Information
#
# Table name: remindmails
#
#  id           :bigint(8)        not null, primary key
#  remind_email :string(255)      default(""), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint(8)
#

class Remindmail < ApplicationRecord
  # #リレーション
  # user
  belongs_to :user
end
