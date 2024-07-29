require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  fixtures :users

  let(:trader) { users(:trader) }

  describe 'user story 2' do
    describe 'GET #edit' do
      it 'returns http success' do
        get :edit, params: { id: 1 }
        expect(response).to have_http_status(:success)
      end
    end

    describe 'PUT #update' do
      it 'returns http success when updating status' do
        patch :update, params: { id: 1, user: { is_pending: false } } # update pending status to false
        expect(response).to have_http_status(:success)
      end
      it 'returns http success when updating first_name' do
        patch :update, params: { id: 1, user: { first_name: "updatedFirstName" } } # update first name
        expect(response).to have_http_status(:success)
      end
      it 'returns http success when updating last_name' do
        patch :update, params: { id: 1, user: { first_name: "updateLastName" } } # update last name
        expect(response).to have_http_status(:success)
      end
      it 'returns http success when updating email' do
        patch :update, params: { id: 1, user: { email: "updatedemail@email.com" }} # update email
        expect(response).to have_http_status(:success)
      end
      it 'returns http success when updating all editable fields' do
        patch :update, params: { id: 1, user: { first_name: "updatedFirstName", last_name: "updatedLastName", email: "updatedemail@email.com"}} # update all fields
        exapct(response).to have_http_status(:success)
      end
  end
end
