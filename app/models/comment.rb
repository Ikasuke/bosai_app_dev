# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id             :bigint(8)        not null, primary key
#  comment_detail :text(65535)      not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  item_id        :bigint(8)
#  user_id        :bigint(8)
#

class Comment < ApplicationRecord
end
