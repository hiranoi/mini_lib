class AddColumnToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :category_code, :string
  end
end
