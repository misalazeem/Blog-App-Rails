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
  scenario 'User Show Page bio, Displaying Recent 3 posts' do
    visit user_path(user)
    expect(page).to have_content('Tom is from Spain')
    expect(page).to have_content('This is the forth post')
    expect(page).to have_content('This is the third post')
    expect(page).to have_content('This is the second post')
  end
  scenario 'There is a See All posts button' do
    visit user_path(user)
    expect(page).to have_button('See All Posts')
    click_link 'See All Posts'
    expect(current_path).to eq(user_posts_path(user))
  end
  scenario 'When I click a users post, it redirects me to that posts show page.' do
    visit user_path(user)
    click_link 'This is the second post'
    expect(current_path).to eq(user_post_path(user, post2))
  end
end
