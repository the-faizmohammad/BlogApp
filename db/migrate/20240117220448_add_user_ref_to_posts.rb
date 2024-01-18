class AddUserRefToPosts < ActiveRecord::Migration[7.1]
  def change
    add_reference :posts, :author, null: false, foreign_key: {to_table: :users}

    # Add index for the foreign key only if it doesn't exist
    add_index :posts, :author_id, unique: true, if_not_exists: true
  end
end
