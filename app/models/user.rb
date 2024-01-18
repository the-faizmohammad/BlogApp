class User < ApplicationRecord
    has_many :posts, foreign_key: 'author_id'
    has_many :comments
    has_many :likes
  
    def three_recent_posts
      posts.where(author: self).order(created_at: :desc).limit(3)
    end
  end
  