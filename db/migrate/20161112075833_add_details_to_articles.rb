class AddDetailsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :url_title, :string
    add_column :articles, :url_thumbnail, :string
    add_column :articles, :url_description, :string
  end
end
