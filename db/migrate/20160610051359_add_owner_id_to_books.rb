class AddOwnerIdToBooks < ActiveRecord::Migration
  def change
    add_column :books, :owner_id, :integer
  end
end
