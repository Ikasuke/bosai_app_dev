class AddItemRefToComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :item, foreign_key: true
  end
end
