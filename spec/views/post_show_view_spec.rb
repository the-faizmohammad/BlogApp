require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  before :all do
    Like.delete_all
    Comment.delete_all
    Post.delete_all
    User.delete_all

    @fu = User.create(name: 'User one', photo: 'link', bio: 'User one Bio.')
    @su = User.create(name: 'User two', photo: 'link', bio: 'User two Bio.')

    3.times { |i| Post.create(author: @fu, title: "Post #{i + 1}", text: "First author Post #{i + 1} body") }
    5.times { |i| Post.create(author: @su, title: "Post #{i + 1}", text: "Second author Post #{i + 1} body") }

    6.times { |i| Comment.create(post: @fu.posts.first, user: @fu, text: "Comment #{i + 1}") }
    3.times { |i| Comment.create(post: @su.posts.first, user: @su, text: "Comment #{i + 1}") }

    6.times { Like.create(post: @fu.posts.first, user: @fu) }
  end

  describe 'show page' do
    it 'should direct to posts show' do
      visit users_path
      click_link(@fu.name)
      click_link(@fu.posts.last.title)
      sleep(1)
      expect(current_path).to eq(user_post_path(@fu, @fu.posts.last))
      visit users_path
      click_link(@su.name)
      click_link(@su.posts[3].title)
      sleep(1)
      expect(current_path).to eq(user_post_path(@su, @su.posts[3]))
    end

    it 'should render post title' do
      visit user_post_path(@fu, @fu.posts.first)
      expect(page).to have_content('Post 1')
    end

    it 'should render user name' do
      visit user_post_path(@fu, @fu.posts.first)
      expect(page).to have_content(@fu.name)
      visit user_post_path(@su, @su.posts.first)
      expect(page).to have_content('User two')
    end

    it 'should render the post body' do
      visit user_post_path(@fu, @fu.posts.first)
      expect(page).to have_content('First author Post 1 body')
    end

    it 'should render number of comments' do
      visit user_post_path(@fu, @fu.posts.first)
      expect(page).to have_content('Comments: 6')
    end

    it 'should render user for each comment' do
      visit user_post_path(@fu, @fu.posts.first)
      @fu.posts.first.comments.each do |comment|
        expect(page).to have_content("@#{comment.user.name}: ")
      end
    end

    it 'should render comments' do
      visit user_post_path(@fu, @fu.posts.first)
      @fu.posts.first.comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end

    it 'should render number of likes' do
      visit user_post_path(@fu, @fu.posts.first)
      expect(page).to have_content('Likes: 6')
    end
  end
end
