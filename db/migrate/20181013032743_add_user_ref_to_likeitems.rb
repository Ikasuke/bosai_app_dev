class AddUserRefToLikeitems < ActiveRecord::Migration[5.2]
  def change
    add_reference :likeitems, :user, foreign_key: true
    add_reference :likeitems, :item, foreign_key: true
  end
end
