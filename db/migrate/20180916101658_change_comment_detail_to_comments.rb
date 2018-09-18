class ChangeCommentDetailToComments < ActiveRecord::Migration[5.2]
  def self.up
  change_column_null :comments, :comment_detail, false
end

def self.down
  change_column_null :comments, :comment_detail, true
end
end
