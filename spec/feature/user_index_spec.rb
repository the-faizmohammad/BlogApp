require 'rails_helper'

RSpec.feature 'User Index Page', type: :feature do
  scenario 'User sees other users' do
    # Assuming you have some users in the database
    user = create(:user, name: 'John Doe')
    visit users_path

    expect(page).to have_content('John Doe')
  end

  scenario 'User sees profile picture for each user' do
    # Assuming you have some users with profile pictures
    user = create(:user, name: 'Jane Doe', photo: 'example.jpg')
    visit users_path

    expect(page).to have_css("img[src*='example.jpg']")
  end

  scenario 'User sees the number of posts each user has written' do
    # Assuming you have some users with posts
    user = create(:user, name: 'Bob', posts: [create(:post, title: 'First Post')])
    visit users_path

    expect(page).to have_content('Bob')
    expect(page).to have_content('1 post')
  end

  scenario 'User is redirected to the user\'s show page on click' do
    user = create(:user, name: 'Alice')
    visit users_path

    click_link 'Alice'

    expect(page).to have_current_path(user_path(user))
  end
end
