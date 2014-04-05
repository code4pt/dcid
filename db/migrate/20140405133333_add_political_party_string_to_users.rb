class AddPoliticalPartyStringToUsers < ActiveRecord::Migration
  def change
    add_column :users, :political_party, :string, default: ''
  end
end
