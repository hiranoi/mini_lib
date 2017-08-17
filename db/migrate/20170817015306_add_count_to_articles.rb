class AddCountToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :article_views_count, :integer,  default: 0
  end
end
