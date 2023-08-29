require 'rails_helper'

RSpec.feature 'Post Index', type: :feature do
  let(:user) { User.create(name: 'Tom', photo: 'https://media.gcflearnfree.org/ctassets/topics/246/share_size_large.jpg', bio: 'Tom is from Spain') }
  let!(:post) { Post.create(author: user, title: 'first post', text: 'Hello World') }
  let!(:comment1) { Comment.create(author: user, post:, text: 'Hello') }
  let!(:comment2) { Comment.create(author: user, post:, text: 'Hi') }
  let!(:comment3) { Comment.create(author: user, post:, text: 'Hey') }
  let!(:like1) { Like.create(author: user, post:) }

  scenario 'See users profile and post interactions' do
    visit user_posts_path(user)
    expect(page).to have_content('Tom')
    expect(page).to have_css("img[alt='Tom']", count: 1)
    expect(page).to have_content('Number of posts: 1')
    expect(page).to have_content('Comments: 3')
    expect(page).to have_content('Likes: 1')
  end

  scenario 'See post title/body/comments' do
    visit user_posts_path(user)
    expect(page).to have_content('Hello World')
    expect(page).to have_content('Hello')
    expect(page).to have_content('first post')
  end

  scenario 'I can see a section for pagination if there are more posts than fit on the view' do
    visit user_posts_path(user)
    expect(page).to have_selector('#pagination')
    expect(page).to have_button('Pagination')
  end

  scenario 'Redirecting to post page when click on the post' do
    visit user_posts_path(user)
    click_link 'first post'
    expect(page).to have_current_path(user_post_path(user, post))
  end
end
