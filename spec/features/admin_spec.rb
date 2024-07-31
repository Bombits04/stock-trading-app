require 'rails_helper'

RSpec.describe 'Admin', type: :feature do
  include Devise::Test::IntegrationHelpers
  fixtures :users
  let(:trader1) { users(:trader) }

  describe 'GET #all_users' do
    it 'returns a success response' do
      sign_in trader1
      visit admin_all_users_path
      expect(page).to have_content('All Users')
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      sign_in trader1
      visit admin_all_users_path
      # click on a random edit button
      edit_buttons = all('a', text: 'Edit')
      edit_buttons.sample.click
      expect(page).to have_content('Edit User')
    end
  end

  describe 'PATCH #update' do
    it 'returns a success response' do
      sign_in trader1
      visit admin_all_users_path
      # click on a random edit button
      edit_buttons = all('a', text: 'Edit')
      edit_buttons.sample.click
      # puts "Current path: #{current_path}" # for debugging
      fill_in 'user_first_name', with: 'updatedFirstName'
      click_button 'Update User'
      expect(page).to have_current_path('/')
    end
  end
end
