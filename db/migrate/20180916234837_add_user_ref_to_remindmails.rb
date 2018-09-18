class AddUserRefToRemindmails < ActiveRecord::Migration[5.2]
  def change
    add_reference :remindmails, :user, foreign_key: true
  end
end
