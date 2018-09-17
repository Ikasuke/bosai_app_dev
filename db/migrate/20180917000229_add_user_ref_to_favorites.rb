class AddUserRefToFavorites < ActiveRecord::Migration[5.2]
  def change
     add_column :favorites, :from_user_id, :bigint  # お気に入りするユーザーの外部キー(user model)
     add_column :favorites, :to_user_id, :bigint  # お気に入りされるユーザーの外部キー(user model)
  end
end
