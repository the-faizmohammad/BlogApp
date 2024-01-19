require 'rails_helper'

RSpec.describe Comment, type: :model do
  before :all do
    @user = User.create(name: 'Comment spec')
    @post = Post.create(author: @user, title: 'Post Title')
  end

  after :all do
    @user.destroy
    @post.destroy
  end

  context '#create instance' do
    it 'User and Post should be valid' do
      expect(Comment.new(user: @user, post: @post)).to be_valid
    end

    it 'check to create comment without a post to the user' do
      expect(Comment.new(user: @user)).to_not be_valid
    end

    it 'check to create comment to a post without a user' do
      expect(Comment.new(post: @post)).to_not be_valid
    end
  end
end
