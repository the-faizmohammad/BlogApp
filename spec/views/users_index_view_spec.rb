require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before :all do
    Like.delete_all
    Comment.delete_all
    Post.delete_all
    User.delete_all

    @fu = User.create(name: 'User one', photo: 'link', bio: 'User one Bio.')
    @su = User.create(name: 'User two', photo: 'link', bio: 'User two Bio.')

    3.times { |i| Post.create(author: @fu, title: "Post #{i + 1}") }
    5.times { |i| Post.create(author: @su, title: "Post #{i + 1}") }
  end

  describe 'index page' do
    it 'should direct to users index' do
      visit users_path
      expect(current_path).to eq(users_path)
    end

    it 'should render user names' do
      visit users_path
      sleep(1)
      expect(page).to have_content(@fu.name)
      expect(page).to have_content('User two')
    end

    it 'should render user photos' do
      visit users_path
      sleep(1)
      expect(page).to have_css('img.user-img')
    end

    it 'should render the number of posts' do
      visit users_path
      sleep(1)
      expect(page).to have_content("Number of posts: #{@fu.posts_counter}")
      expect(page).to have_content('Number of posts: 5')
    end
  end

  describe 'posts routing' do
    it 'should redirect to first user' do
      visit users_path
      sleep(1)
      click_link(@fu.name)
      sleep(1)
      expect(current_path).to eq(user_path(@fu))
    end

    it 'should redirect to second user' do
      visit users_path
      sleep(1)
      click_link(@su.name)
      sleep(1)
      expect(current_path).to eq(user_path(@su))
    end
  end
end