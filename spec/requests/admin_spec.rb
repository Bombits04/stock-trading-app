require 'rails_helper'

RSpec.describe AdminController, type: :request do
  include Devise::Test::IntegrationHelpers
  fixtures :users

  let(:admin) { users(:one) }
  let(:trader1) { users(:trader) }

  describe 'GET #all_users' do
    it 'returns a success response' do
      sign_in admin
      get admin_all_users_path
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      sign_in admin
      get edit_user_path(trader1)
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    it 'returns a redirect response' do
      sign_in admin
      patch update_user_path(trader1), params: { user: { first_name: 'updatedFirstName' } }
      trader1.reload
      expect(trader1.first_name).to eq('updatedFirstName')
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'PATCH #update with invalid params' do
    it 'returns an unprocessable entity response when first name is empty' do
      sign_in admin
      patch update_user_path(trader1), params: { user: { first_name: '' } }
      trader1.reload
      expect(response).to have_http_status(422)
      expect(response).to render_template(:edit)
    end

    it 'returns an unprocessable entity response when last name is empty' do
      sign_in admin
      patch update_user_path(trader1), params: { user: { last_name: '' } }
      trader1.reload
      expect(response).to have_http_status(422)
      expect(response).to render_template(:edit)
    end

    it 'returns an unprocessable entity response when email is empty' do
      sign_in admin
      patch update_user_path(trader1), params: { user: { email: '' } }
      trader1.reload
      expect(response).to have_http_status(422)
      expect(response).to render_template(:edit)
    end

    it 'returns an unprocessable entity response when first_name, last_name, email are empty' do
      sign_in admin
      patch update_user_path(trader1), params: { user: { first_name: '', last_name: '', email: '' } }
      trader1.reload
      expect(response).to have_http_status(422)
      expect(response).to render_template(:edit)
    end
  end
end
