class AddSubcategoryRefToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :subcategory, foreign_key: true
  end
end
