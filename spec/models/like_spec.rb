require 'rails_helper'

RSpec.describe Like, type: :model do
  before :all do
    @user = User.create(name: 'Like spec')
    @post = Post.create(author: @user, title: 'Post Title')
  end

  context '#create instance' do
    it 'User and Post should be valid' do
      expect(Like.new(user: @user, post: @post)).to be_valid
    end

    it 'check to create like if there user without post' do
      expect(Like.new(user: @user)).to_not be_valid
    end

    it 'check to create like to a post without user' do
      expect(Like.new(post: @post)).to_not be_valid
    end
  end

  context '#update_likes_counter private method' do
    it 'likes_counter default value 0' do
      expect(@post.likes_counter).to eq 0
    end

    it 'should update the likes_counter' do
      6.times { Like.create(user: @user, post: @post) }
      expect(@post.likes_counter).to eq 6
    end
  end
end
