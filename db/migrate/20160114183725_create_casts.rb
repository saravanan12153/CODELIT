class CreateCasts < ActiveRecord::Migration
  def change
    create_table :casts do |t|
      t.string :title
      t.string :video
      t.text :transcript
      t.boolean :publish, default: false
      t.string :slug

      t.timestamps null: false
    end
  end
end
