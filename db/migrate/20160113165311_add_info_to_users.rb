class AddInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :about, :text
    add_column :users, :facebook, :string
    add_column :users, :twitter, :string
    add_column :users, :git, :string
    add_column :users, :website, :string
    add_column :users, :linkedin, :string
  end
end
