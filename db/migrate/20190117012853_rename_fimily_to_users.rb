class RenameFimilyToUsers < ActiveRecord::Migration[5.2]
  def up
    rename_column :users, :family_senior, :senior
    rename_column :users, :family_middle, :middle
    rename_column :users, :family_junior, :junior
    rename_column :users, :family_infant, :infant
  end

  def down
    rename_column :users, :senior, :family_senior
    rename_column :users, :middle, :family_middle
    rename_column :users, :junior, :family_junior
    rename_column :users, :infant, :family_infant
  end
end
