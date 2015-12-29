class AddCompletedToEnrols < ActiveRecord::Migration
  def change
    add_column :enrols, :complete, :boolean, default: false
  end
end
