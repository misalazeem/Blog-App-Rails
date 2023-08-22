require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { User.create(name: 'Misal') }
  let(:post) { Post.create(author: user, title: 'Hello World') }

  describe 'GET /index' do
    before do
      get user_posts_path(user)
    end

    context 'Index page is loaded' do
      it 'Response status is 200' do
        expect(response).to have_http_status(200)
      end

      it 'correct template is loaded' do
        expect(response).to render_template(:index)
      end

      it 'response body contains correct text' do
        expect(response.body).to include('Posts by')
      end
    end
  end
  describe 'GET #show' do
    before do
      get user_post_path(user, post)
    end

    context 'Renders the Post show page' do
      it 'Response status is 200' do
        expect(response).to have_http_status(200)
      end

      it 'correct template is loaded' do
        expect(response).to render_template(:show)
      end

      it 'reponse body contains the correct text' do
        expect(response.body).to include('Post ID')
      end
    end
  end
end
