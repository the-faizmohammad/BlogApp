class AddUserRefToComments < ActiveRecord::Migration[7.1]
  def change
    add_reference :comments, :user, null: false, foreign_key: true

    # Add index for the foreign key only if it doesn't exist
    add_index :comments, :user_id, if_not_exists: true
  end
end
