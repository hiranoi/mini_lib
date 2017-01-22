class AddDetailsToBooks < ActiveRecord::Migration
  def change
    add_column :books, :amazon_url, :string
    add_column :books, :image_url, :string
    add_column :books, :description, :string
  end
end
