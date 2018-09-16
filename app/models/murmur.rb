# frozen_string_literal: true

# == Schema Information
#
# Table name: murmurs
#
#  id            :bigint(8)        not null, primary key
#  murmur_detail :text(65535)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Murmur < ApplicationRecord
end
