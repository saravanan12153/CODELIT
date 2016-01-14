class AddNviewsToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :count_views, :integer, default: 0
  end
end
