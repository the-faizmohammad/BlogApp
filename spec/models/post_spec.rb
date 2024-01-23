require 'rails_helper'

RSpec.describe Post, type: :model do
  before :all do
    @subject = User.create(name: 'Post spec')
  end

  context '#create instance' do
    it 'Post should be valid for the user' do
      expect(Post.new(author: @subject, title: 'Post Title')).to be_valid
    end

    it 'post title should be present' do
      expect(Post.new(author: @subject, title: nil)).to_not be_valid
    end

    it 'post title should be of max length 250 chars' do
      expect(Post.new(author: @subject, title: 'a' * 251)).to_not be_valid
    end
  end

  context 'check validations' do
    new_post = Post.new(author: @subject, title: 'AAA')

    it 'post comments_counter default should be 0' do
      expect(new_post.comments_counter).to eq(0)
    end

    it 'post likes_counter default should be 0' do
      expect(new_post.likes_counter).to eq(0)
    end

    it 'post comments_counter should not be a string' do
      new_post.comments_counter = 'count'
      expect(new_post).to_not be_valid
    end

    it 'post comments_counter should not be a string' do
      new_post.likes_counter = 'count'
      expect(new_post).to_not be_valid
    end
  end

  context '#five_recent_comments' do
    before :all do
      @new_post = Post.create(author: @subject, title: 'xyz')
      6.times { |i| Comment.create(user: @subject, post: @new_post, text: "comment #{i + 1}") }
    end

    it 'check if there are no comments to a user' do
      expect(Post.new(author: @subject, title: 'qwerty').five_recent_comments.length).to eq(0)
    end

    it 'should return five recent comments of a user post' do
      expect(@new_post.five_recent_comments.length).to eq 5
    end

    it 'check the title of first comment from five recent comments' do
      comments = @new_post.five_recent_comments
      expect(comments.first.text).to eq('comment 6')
    end

    it 'check the title of last post from three recent posts' do
      comments = @new_post.five_recent_comments
      expect(comments.last.text).to eq('comment 2')
    end
  end

  context '#update_posts_counter private method' do
    it 'Update the posts_counter for a user' do
      expect(@subject.posts_counter).to eq 1
    end

    it 'check posts_counter if created new posts' do
      3.times { Post.create(author: @subject, title: 'user posts') }
      expect(@subject.posts_counter).to eq 4
    end
  end
end
