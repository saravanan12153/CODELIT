class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.string :title
      t.string :video
      t.text :external
      t.text :transcript
      t.integer :seq
      t.boolean :publish, default: false

      t.timestamps null: false
    end
  end
end
