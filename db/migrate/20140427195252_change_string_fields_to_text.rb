class ChangeStringFieldsToText < ActiveRecord::Migration
  def change
    change_column :proposals, :problem, :text, :limit => nil
    change_column :proposals, :solution, :text, :limit => nil
  end
end
