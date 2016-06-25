class ChangColumnToArticle < ActiveRecord::Migration
  def self.up
          change_column :articles, :user_id, :'integer USING CAST(user_id AS integer)'
  end

  def self.down
          change_column :articles, :user_id, :string
  end
end
