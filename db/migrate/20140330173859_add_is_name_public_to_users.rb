class AddIsNamePublicToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_name_public, :boolean
  end
end
