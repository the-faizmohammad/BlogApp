require 'rails_helper'

RSpec.feature 'Post Show Page', type: :feature do
  scenario 'User sees post details, author, comments, likes, and commenters' do
    user = create(:user, name: 'Alice')
    post = create(:post, title: 'My First Post', author: user, comments: [create(:comment), create(:comment)])
    visit user_post_path(user, post)

    expect(page).to have_content('My First Post')
    expect(page).to have_content('Alice')
    expect(page).to have_content("Comments: #{post.comments.count}")
    expect(page).to have_content("Likes: #{post.likes.count}")
    expect(page).to have_content(post.body)

    post.comments.each do |comment|
      expect(page).to have_content(comment.user.name)
      expect(page).to have_content(comment.text)
    end
  end
end
