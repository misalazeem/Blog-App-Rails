require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  let!(:user) { User.create(name: 'Misal') }
  
  describe 'GET /index' do
    before do
      get users_path
    end

    context 'Index template is rendered' do
      it 'response status is 200' do
        expect(response).to have_http_status(200)
      end

      it 'correct template is loaded' do
        expect(response).to render_template(:index)
      end

      it 'should have the correct heading' do
        expect(response.body).to include('List of Users')
      end
    end
  end

  describe 'GET #show' do
    before do
      get user_path(user)
    end

    context 'Renders the User show page' do
      it 'Response status is 200' do
        expect(response).to have_http_status(200)
      end

      it 'correct template is loaded' do
        expect(response).to render_template(:show)
      end

      it 'reponse body contains the correct text' do
        expect(response.body).to include('Misal')
      end
    end
  end
end
