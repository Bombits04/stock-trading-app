require 'rails_helper'

RSpec.describe AdminController, type: :request do
  fixtures :users

  let(:admin) { users(:one) }
  let(:trader) { users(:trader) }
  let(:valid_attributes) { { first_name: 'John', last_name: 'Doe', email: 'newtrader@example.com', password: 'password', password_confirmation: 'password', is_pending: false } }
  let(:invalid_attributes) { { first_name: '', last_name: '', email: '', password: '', password_confirmation: '', is_pending: false } }

  before do
    sign_in admin
  end

  describe "GET /admin/all_users" do
    it "returns a success response" do
      get admin_all_users_path
      expect(response).to be_successful
    end
  end

  describe "GET /admin/new" do
    it "returns a success response" do
      get new_admin_path
      expect(response).to be_successful
    end
  end

  describe "GET /admin/all_users/:id/edit" do
    it "returns a success response" do
      get edit_user_path(trader)
      expect(response).to be_successful
    end
  end

  describe "GET /admin/show/:id" do
    it "returns a success response" do
      get show_user_path(trader)
      expect(response).to be_successful
    end
  end

  describe "POST /admin/create" do
    context "with valid parameters" do
      it "creates a new User" do
        expect {
          post create_admin_path, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it "redirects to the admin_all_users_path" do
        post create_admin_path, params: { user: valid_attributes }
        expect(response).to redirect_to(admin_all_users_path)
      end
    end

    context "with invalid parameters" do
      it "does not create a new User" do
        expect {
          post create_admin_path, params: { user: invalid_attributes }
        }.to change(User, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post create_admin_path, params: { user: invalid_attributes }
        expect(response).to be_unprocessable
      end
    end
  end

  describe "PATCH /admin/all_users/:id" do
    context "with valid parameters" do
      let(:new_attributes) { { first_name: 'Jane', last_name: 'Doe', email: 'janedoe@example.com' } }

      it "updates the requested user" do
        patch update_user_path(trader), params: { user: new_attributes }
        trader.reload
        expect(trader.first_name).to eq('Jane')
        expect(trader.last_name).to eq('Doe')
        expect(trader.email).to eq('janedoe@example.com')
      end

      it "redirects to the admin_all_users_path" do
        patch update_user_path(trader), params: { user: new_attributes }
        trader.reload
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch update_user_path(trader), params: { user: invalid_attributes }
        expect(response).to be_unprocessable
      end
    end
  end
end