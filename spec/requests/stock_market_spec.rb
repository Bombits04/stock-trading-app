require 'rails_helper'

RSpec.describe 'StockMarkets', type: :request do
  include Devise::Test::IntegrationHelpers
  fixtures :users, :stocks
  let(:user) { users(:trader) } # trader info
  let(:stock) { stocks(:stock1) }

  before do
    sign_in user
  end

  describe 'GET /index' do
    # let!(:stock_market) { create(:stock_market) }

    it 'returns a successful response' do
      get home_stockmarket_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get home_stockmarket_path
      expect(response).to render_template(:index)
    end

    it 'includes the stock market in the response body' do
      get home_stockmarket_path
      expect(response.body).to include(stock.company_name)
    end
  end
end
