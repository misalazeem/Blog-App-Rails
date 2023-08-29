require 'rails_helper'

RSpec.feature 'Post Show', type: :feature do
  let(:user) { User.create(name: 'Tom', photo: 'https://media.gcflearnfree.org/ctassets/topics/246/share_size_large.jpg', bio: 'Tom is from Spain') }
  let!(:post) { Post.create(author: user, title: 'first post', text: 'This is the first post') }
  let!(:post2) { Post.create(author: user, title: 'second post', text: 'This is the second post') }
  let!(:post3) { Post.create(author: user, title: 'third post', text: 'This is the third post') }
  let!(:post4) { Post.create(author: user, title: 'forth post', text: 'This is the forth post') }
  let!(:comment1) { Comment.create(author: user, post:, text: 'Hello') }
  let!(:comment2) { Comment.create(author: user, post:, text: 'Hi') }
  let!(:comment3) { Comment.create(author: user, post:, text: 'Hey') }
  let!(:like1) { Like.create(author: user, post:) }

  scenario 'View the post and its interactions' do
    visit user_post_path(user, post)
    expect(page).to have_content('first post')
    expect(page).to have_content('by Tom')
    expect(page).to have_content('Comments: 3')
    expect(page).to have_content('Likes: 1')
  end

  scenario 'Post body view' do
    visit user_post_path(user, post)
    expect(page).to have_content('This is the first post')
  end

  scenario 'Checking comment views' do
    user2 = User.create(name: 'Lily')
    user3 = User.create(name: 'Misal')
    Comment.create(author: user2, post:, text: 'fifth comment')
    Comment.create(author: user3, post:, text: 'sixth comment')

    visit user_post_path(user, post)

    expect(page).to have_content('Lily')
    expect(page).to have_content('Misal')
    expect(page).to have_content('sixth comment')
  end
end
