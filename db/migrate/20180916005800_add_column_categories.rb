class AddColumnCategories < ActiveRecord::Migration[5.2]
  def up
   add_column :categories, :category_name, :string, null:false, default: ""
  end

  def down
   remove_column :categories, :category_name
  end
end
