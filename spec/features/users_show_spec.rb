require 'rails_helper'

RSpec.feature 'User Show', type: :feature do
  let(:user) { User.create(name: 'Tom', photo: 'https://media.gcflearnfree.org/ctassets/topics/246/share_size_large.jpg', bio: 'Tom is from Spain') }
  let!(:post1) { Post.create(author: user, title: 'first post', text: 'This is the first post') }
  let!(:post2) { Post.create(author: user, title: 'second post', text: 'This is the second post') }
  let!(:post3) { Post.create(author: user, title: 'third post', text: 'This is the third post') }
  let!(:post4) { Post.create(author: user, title: 'forth post', text: 'This is the forth post') }
  scenario 'User Show Page' do
    visit user_path(user)
    expect(page).to have_content('Tom')
    expect(page).to have_css("img[alt='Tom']", count: 1)
  end
  scenario 'visiting the user show page, you see the number of posts the user has written..' do
    visit user_path(user)
    expect(page).to have_content('Number of posts: 4')
  end
  scenario 'User Show Page, Displaying Recent 3 posts' do
    visit user_path(user)
    expect(page).to have_content('Tom is from Spain')
    expect(page).not_to have_content('fist text')
  end
end
