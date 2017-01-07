class AddRentUserIdToBooks < ActiveRecord::Migration
  def change
    add_column :books, :rent_user_id, :integer
  end
end
