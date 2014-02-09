class AddIndexToUsersCitizenNumber < ActiveRecord::Migration
  def change
    add_index :users, :citizen_number, unique: true
  end
end
