require 'rails_helper'

RSpec.describe Comment, type: :model do
  before :all do
    @user = User.create(name: 'Comment spec')
    @post = Post.create(author: @user, title: 'Post Title')
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

  context '#update_comments_counter' do
    it 'comments_counter default value 0' do
      expect(@post.comments_counter).to eq 0
    end

    it 'updates comments_counter if new comments created' do
      2.times { |i| Comment.create(user: @user, post: @post, text: "comment #{i + 1}") }
      expect(@post.comments_counter).to eq 2
    end
  end
end
