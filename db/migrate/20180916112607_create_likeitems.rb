class CreateLikeitems < ActiveRecord::Migration[5.2]
  def change
    create_table :likeitems do |t|

      t.timestamps
    end
  end
end
