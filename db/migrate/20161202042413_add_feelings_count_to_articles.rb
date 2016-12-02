class AddFeelingsCountToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :feelings_count, :integer, default:0
  end
end
