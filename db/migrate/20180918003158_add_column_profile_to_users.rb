class AddColumnProfileToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :public_name, :string, null:false, default: ""
    add_column :users, :area1, :string, null:false, default: ""
    add_column :users, :area2, :string
    add_column :users, :family, :string
  end

def down
  remove_column :users, :public_name, :string, null:false, default: ""
  remove_column :users, :area1, :string, null:false, default: ""
  remove_column :users, :area2, :string
  remove_column :users, :family, :string
end

end
