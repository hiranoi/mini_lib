class RemoveSyokoFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :syoko, :boolean
  end
end
