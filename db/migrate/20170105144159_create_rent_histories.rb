class CreateRentHistories < ActiveRecord::Migration
  def change
    create_table :rent_histories do |t|
      t.integer :user_id
      t.integer :book_id

      t.timestamps null: false
    end
  end
end
