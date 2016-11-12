class CreateFeelings < ActiveRecord::Migration
  def change
    create_table :feelings do |t|
      t.string :target
      t.integer :user_id
      t.integer :target_id
      t.text :feeling

      t.timestamps null: false
    end
  end
end
