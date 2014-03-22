class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.string :title
      t.string :problem
      t.string :solution
      t.integer :upvotes
      t.integer :downvotes
      t.integer :user_id

      t.timestamps
    end
    add_index :proposals, [:title, :user_id]
  end
end
