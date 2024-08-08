# spec/features/trader_spec.rb
require 'rails_helper'

RSpec.describe 'Trader', type: :feature do
  include Devise::Test::IntegrationHelpers
  fixtures :users, :stocks

  let(:trader) { users(:trader) }
  let(:stock) { stocks(:one) }

  before do
    sign_in trader
  end

  describe 'Home' do
    it 'displays the trader dashboard' do
      visit home_path
      expect(page).to have_content('Your Profile')
    end
  end

  describe 'Stock Purchase' do
    it 'allows the trader to create a new stock purchase' do
      visit home_stockmarket_path
      click_on ('Add Stock')
      expect(page).to have_content('My Stocks')
      expect(page).to have_content('Stock added successfully!')
    end
  end

  describe 'Portofolio' do
    it 'displays the user\'s portofolio' do
      visit home_path
      expect(page).to have_content('Your Profile')
      click_on ('My Portfolio')
      expect(page).to have_content('My Stocks')
    end
  end

  describe 'Selling stocks' do
    it 'sells a stock from user\'s portfolio' do
      visit home_path
      expect(page).to have_content('Your Profile')
      click_on ('Stock Market')
      expect(page).to have_content('Stock Market')
      click_on ('Add Stock')
      expect(page).to have_content('Delete')
      click_on ('Delete')
      expect(page).to have_content('No stocks available in your portfolio.')
    end
  end
end
