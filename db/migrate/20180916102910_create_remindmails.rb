class CreateRemindmails < ActiveRecord::Migration[5.2]
  def change
    create_table :remindmails do |t|
      t.string :remind_email, null: false, default:""

      t.timestamps
    end
  end
end
