class AddUniqueIndexToUsersEmail < ActiveRecord::Migration[7.1]
  def up
    remove_index :users, :email if index_exists?(:users, :email)
    add_index :users, :email, if_not_exists: true
  end

  def down
    remove_index :users, :email if index_exists?(:users, :email)
  end
end
