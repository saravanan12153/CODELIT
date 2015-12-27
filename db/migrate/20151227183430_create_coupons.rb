class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :name
      t.integer :course_id
      t.integer :total
      t.decimal :percent

      t.timestamps null: false
    end
  end
end
