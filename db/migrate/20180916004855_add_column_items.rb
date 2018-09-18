class AddColumnItems < ActiveRecord::Migration[5.2]
 def up
  add_column :items, :item_name, :string, null:false, default: ""
  add_column :items, :item_volume, :string, null:false, default: ""
  add_column :items, :item_expiry, :datetime
  add_column :items, :item_picture_file, :string
  add_column :items, :item_public_memo, :text
  add_column :items, :item_private_memo, :text
  add_column :items, :item_open_flag, :boolean, null:false, default:1
 end

 def down
  remove_column :items, :item_name
  remove_column :items, :item_volume
  remove_column :items, :item_expiry
  remove_column :items, :item_picture_file
  remove_column :items, :item_public_memo
  remove_column :items, :item_private_memo
  remove_column :items, :item_open_flag
 end
    
end
