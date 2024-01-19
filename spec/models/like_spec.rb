require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'is valid with a user and post' do
    user = User.create(name: 'Liker')
    post = Post.create(title: 'Test Post', text: 'This is a test post.', author: user)
    like = Like.new(user:, post:)
    expect(like).to be_valid
  end

  it 'is invalid without a user' do
    post = Post.create(title: 'Test Post', text: 'This is a test post.')
    like = Like.new(post:)
    expect(like).to_not be_valid
  end

  it 'is invalid without a post' do
    user = User.create(name: 'Liker')
    like = Like.new(user:)
    expect(like).to_not be_valid
  end
end
