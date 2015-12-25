class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.string :subtitle
      t.text :description
      t.string :promo
      t.decimal :price
      t.boolean :publish

      t.timestamps null: false
    end
  end
end
