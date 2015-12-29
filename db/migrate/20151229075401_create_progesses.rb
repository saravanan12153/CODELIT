class CreateProgesses < ActiveRecord::Migration
  def change
    create_table :progesses do |t|
      t.integer :user_id
      t.integer :lecture_id
      t.string :status

      t.timestamps null: false
    end
  end
end
