class ChangeFamilyToUsers < ActiveRecord::Migration[5.2]
  def up
    remove_column :users, :family, :string
    add_column :users, :family_senior, :integer, default: 0, null: false
    add_column :users, :family_middle, :integer, default: 0, null: false
    add_column :users, :family_junior, :integer, default: 0, null: false
    add_column :users, :family_infant, :integer, default: 0, null: false
  end

  def down
    add_column :users, :family, :string
    remove_column :users, :family_senior
    remove_column :users, :family_middle
    remove_column :users, :family_junior
    remove_column :users, :family_infant
  end
end
