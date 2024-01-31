require 'rails_helper'

RSpec.feature 'User Show Page', type: :feature do
  scenario 'User sees user\'s profile picture' do
    user = create(:user, name: 'John Doe', photo: 'example.jpg')
    visit user_path(user)

    expect(page).to have_css("img[src*='example.jpg']")
  end

  scenario 'User sees user\'s username, bio, and first 3 posts' do
    # Assuming you have a method 'three_recent_posts' in your User model
    user = create(:user, name: 'Jane', bio: 'Lorem ipsum')
    posts = create_list(:post, 4, author: user)
    visit user_path(user)

    expect(page).to have_content('Jane')
    expect(page).to have_content('Lorem ipsum')
    expect(page).to have_content(posts[0].title)
    expect(page).to have_content(posts[1].title)
    expect(page).to have_content(posts[2].title)
    expect(page).not_to have_content(posts[3].title)
  end

  scenario 'User can view all of a user\'s posts' do
    user = create(:user, name: 'Bob')
    visit user_path(user)

    click_link 'View All Posts'

    expect(page).to have_current_path(user_posts_path(user))
  end

  scenario 'User is redirected to a post\'s show page on click' do
    user = create(:user, name: 'Alice')
    post = create(:post, title: 'First Post', author: user)
    visit user_path(user)

    click_link 'First Post'

    expect(page).to have_current_path(user_post_path(user, post))
  end
end
