class AddColumnUsers < ActiveRecord::Migration[5.2]
  def up
   add_column :users, :name, :string, null:false, default: ""
   add_column :users, :role, :integer, null:false, default: 0   #管理者かどうか
  end

  def down
   remove_column :users, :name
   remove_column :users, :role
  end
end
