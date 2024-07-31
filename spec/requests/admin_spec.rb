require 'rails_helper'

RSpec.describe AdminController, type: :request do
  include Devise::Test::IntegrationHelpers
  fixtures :users

  let(:trader1) { users(:trader) }

  describe 'GET #all_users' do
    it 'returns a success response' do
      sign_in trader1
      get admin_all_users_path
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      sign_in trader1
      get edit_user_path(trader1)
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    it 'returns a success response' do
      sign_in trader1
      patch update_user_path(trader1), params: { user: { first_name: 'updatedFirstName' } }
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'PATCH #update with invalid params' do
    it 'returns an unprocessable entity response when first name is empty' do
      sign_in trader1
      patch update_user_path(trader1), params: { user: { first_name: '' } }
      expect(response).to have_http_status(422)
      expect(response).to render_template(:edit)
    end

    it 'returns an unprocessable entity response when last name is empty' do
      sign_in trader1
      patch update_user_path(trader1), params: { user: { last_name: '' } }
      expect(response).to have_http_status(422)
      expect(response).to render_template(:edit)
    end

    it 'returns an unprocessable entity response when email is empty' do
      sign_in trader1
      patch update_user_path(trader1), params: { user: { email: '' } }
      expect(response).to have_http_status(422)
      expect(response).to render_template(:edit)
    end

    it 'returns an unprocessable entity response when first_name, last_name, email is empty' do
      sign_in trader1
      patch update_user_path(trader1), params: { user: { first_name: '', last_name: '', email: '' } }
      expect(response).to have_http_status(422)
      expect(response).to render_template(:edit)
    end
  end
end
