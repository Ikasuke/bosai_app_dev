class AddColumnToSubcategories < ActiveRecord::Migration[5.2]
  def up
    add_column :subcategories, :subcategory_name, :string, null: false, default: ""
  end

  def down
    remove_column :subcategories, :subcategory_name
  end
end
