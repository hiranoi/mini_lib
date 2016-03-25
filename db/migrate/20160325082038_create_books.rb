class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :user_id
      t.string :title
      t.string :author
      t.string :publisher
      t.bigint :isbn

      t.timestamps null: false
    end
  end
end
