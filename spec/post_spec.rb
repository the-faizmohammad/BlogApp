require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is valid with a title, text, and author' do
    user = User.create(name: 'Author')
    post = Post.new(title: 'Test Post', text: 'This is a test post.', author: user)
    expect(post).to be_valid
  end

  it 'is invalid without a title' do
    post = Post.new(title: nil, text: 'This is a test post.')
    expect(post).to_not be_valid
  end

  it 'is invalid with a title exceeding 250 characters' do
    post = Post.new(title: 'a' * 251, text: 'This is a test post.')
    expect(post).to_not be_valid
  end
end
