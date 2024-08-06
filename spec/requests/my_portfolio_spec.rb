require 'rails_helper'

RSpec.describe 'MyPortfolios', type: :request do
  include Devise::Test::IntegrationHelpers
  fixtures :users, :stocks
  let(:user) { users(:trader) } # trader info
  let(:stock) { stocks(:stock1) }

  before do
    sign_in user
  end

  describe 'GET /index' do
    it 'returns a successful response' do
      get home_myportfolio_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get home_myportfolio_path
      expect(response).to render_template(:my_stocks)
    end

    it "includes the user's stocks in the response body" do
      get home_myportfolio_path
      expect(response.body).to include('No stocks available in your portfolio.')
    end
  end
end
