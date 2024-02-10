class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  after_save :update_comments_counter
  after_create :set_user_id

  private

  def update_comments_counter
    post.increment!(:comments_counter)
  end

  def set_user_id
    update!(user_id: Current.user.id)
  end
end
