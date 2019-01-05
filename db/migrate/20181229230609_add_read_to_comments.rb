class AddReadToComments < ActiveRecord::Migration[5.2]
  def up
    add_column :comments, :read, :integer, null: false, default: 0   #コメントを既読したかどうか
  end

  def down
    remove_column :comments, :read
  end
end
