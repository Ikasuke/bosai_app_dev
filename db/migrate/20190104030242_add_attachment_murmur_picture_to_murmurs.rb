class AddAttachmentMurmurPictureToMurmurs < ActiveRecord::Migration[5.1]
  def self.up
    change_table :murmurs do |t|
      t.attachment :murmur_picture
    end
  end

  def self.down
    remove_attachment :murmurs, :murmur_picture
  end
end
