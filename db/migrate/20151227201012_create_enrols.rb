class CreateEnrols < ActiveRecord::Migration
  def change
    create_table :enrols do |t|
      t.integer :user_id
      t.integer :course_id
      t.decimal :price
      t.string :guid

      t.timestamps null: false
    end
  end
end
