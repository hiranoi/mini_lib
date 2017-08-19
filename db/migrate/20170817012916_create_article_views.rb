class CreateArticleViews < ActiveRecord::Migration
  def change
    create_table :article_views do |t|
      t.integer :user_id
      t.integer :article_id

      t.timestamps null: false
    end
  end
end
