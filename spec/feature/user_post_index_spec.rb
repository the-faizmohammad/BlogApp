require 'rails_helper'

RSpec.feature 'User Post Index Page', type: :feature do
  scenario 'User sees user\'s profile picture, username, number of posts, post details, comments, likes, and pagination' do
    user = create(:user, name: 'John Doe')
    posts = create_list(:post, 3, author: user, comments: [create(:comment), create(:comment)])
    visit user_posts_path(user)

    expect(page).to have_css("img[src*='user_profile.jpg']")
    expect(page).to have_content('John Doe')
    expect(page).to have_content('3 posts')

    posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.body)
      expect(page).to have_content("Comments: #{post.comments.count}")
      expect(page).to have_content("Likes: #{post.likes.count}")
    end

    expect(page).to have_selector('div.pagination')
  end

  scenario 'User is redirected to a post\'s show page on click' do
    user = create(:user, name: 'Alice')
    post = create(:post, title: 'First Post', author: user)
    visit user_posts_path(user)

    click_link 'First Post'

    expect(page).to have_current_path(user_post_path(user, post))
  end
end
