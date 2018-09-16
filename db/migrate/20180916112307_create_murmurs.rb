class CreateMurmurs < ActiveRecord::Migration[5.2]
  def change
    create_table :murmurs do |t|
      t.text :murmur_detail, null: false

      t.timestamps
    end
  end
end
