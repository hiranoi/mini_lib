class CreateRentHistories < ActiveRecord::Migration
  def change
    create_table :rent_histories do |t|
      t.string :name
      t.string :book

      t.timestamps null: false
    end
  end
end
