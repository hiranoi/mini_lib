class CreatePushes < ActiveRecord::Migration
  def change
    create_table :pushes do |t|
      t.string :type
      t.string :title
      t.string :text

      t.timestamps null: false
    end
  end
end
