class CreateFeelings < ActiveRecord::Migration
  def change
    create_table :feelings do |t|
      t.integer :user_id
      t.integer :article_id
      t.text :feeling

      t.timestamps null: false
    end
  end
end
