class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.string :slide_id
      t.string :title
      t.string :url
      t.string :thumbnail_url
      t.string :embed
      t.string :recommend_comment
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
