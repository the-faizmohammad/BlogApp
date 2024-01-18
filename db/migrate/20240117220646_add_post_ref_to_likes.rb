class AddPostRefToLikes < ActiveRecord::Migration[7.1]
  def change
    add_reference :likes, :post, null: false, foreign_key: true

    # Add index for the foreign key
    add_index :likes, :post_id, if_not_exists: true
  end
end
