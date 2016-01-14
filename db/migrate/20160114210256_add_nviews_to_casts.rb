class AddNviewsToCasts < ActiveRecord::Migration
  def change
    add_column :casts, :count_views, :integer, default: 0
  end
end
