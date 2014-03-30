class AddIsNamePublicToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_name_public, :boolean, default: true
  end
end
