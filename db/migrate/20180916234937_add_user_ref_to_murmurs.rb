class AddUserRefToMurmurs < ActiveRecord::Migration[5.2]
  def change
    add_reference :murmurs, :user, foreign_key: true
  end
end
