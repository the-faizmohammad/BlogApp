require 'rails_helper'

RSpec.describe User, type: :model do
  before :all do
    @user = User.create(name: 'User spec')
  end

  context '#Create instance' do
    it 'User should be valid' do
      expect(@user).to be_valid
    end

    it 'name should be present' do
      @user.name = nil
      expect(@user).to_not be_valid
    end

    it 'posts_counter default should be 0' do
      expect(@user.posts_counter).to eq 0
    end

    it 'posts_counter should be a integer' do
      @user.posts_counter = nil
      expect(@user).to_not be_valid
    end

    it 'posts_counter should not be a string' do
      @user.posts_counter = 'count'
      expect(@user).to_not be_valid
    end

    it 'posts_counter should not be a float' do
      @user.posts_counter = 1.5
      expect(@user).to_not be_valid
    end

    it 'posts_counter should be a positive integer' do
      @user.posts_counter = 2
      @user.name = 'Faiz'
      expect(@user).to be_valid
    end
  end

  context '#three_recent_posts' do
    new_user = User.new(name: 'Giza')
    4.times { |i| Post.create(author: new_user, title: "Post #{i + 1}") }

    it 'check if there are no posts to a user' do
      expect(@user.three_recent_posts.length).to eq(0)
    end

    it 'should return three recent posts of a user' do
      expect(new_user.three_recent_posts.length).to eq 3
    end

    it 'check the title of first post from three recent posts' do
      posts = new_user.three_recent_posts
      expect(posts.first.title).to eq('Post 4')
    end

    it 'check the title of last post from three recent posts' do
      posts = new_user.three_recent_posts
      expect(posts.last.title).to eq('Post 2')
    end
  end
end