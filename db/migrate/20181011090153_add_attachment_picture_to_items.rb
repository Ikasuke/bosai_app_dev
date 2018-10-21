class AddAttachmentPictureToItems < ActiveRecord::Migration[5.1]
  def self.up
    change_table :items do |t|
      t.attachment :picture
    end
    remove_column :items, :item_picture_file
  end

  def self.down
    remove_attachment :items, :picture
    add_column :items, :item_picture_file, :string
  end
end
