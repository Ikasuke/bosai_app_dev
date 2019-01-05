class AddAttachmentCommentPictureToComments < ActiveRecord::Migration[5.1]
  def self.up
    change_table :comments do |t|
      t.attachment :comment_picture
    end
  end

  def self.down
    remove_attachment :comments, :comment_picture
  end
end
