class AddCommentsCountToBooks < ActiveRecord::Migration
  def change
    add_column :books, :comments_count, :integer
  end
end
