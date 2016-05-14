class AddFlagsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :syoko, :boolean
    add_column :users, :place, :string
  end
end
