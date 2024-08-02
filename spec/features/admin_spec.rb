require 'rails_helper'

RSpec.describe 'Admin', type: :feature do
  include Devise::Test::IntegrationHelpers
  fixtures :users
  let(:admin1) { users(:one) }

  describe 'GET #all_users' do
    it 'returns a success response' do
      sign_in admin1
      visit admin_all_users_path
      expect(page).to have_content('All Users')
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      sign_in admin1
      visit admin_all_users_path
      # click on a random edit button
      edit_buttons = all('a', text: 'Edit')
      edit_buttons.sample.click
      expect(page).to have_content('Edit User')
    end
  end

  describe 'PATCH #update' do
    it 'returns a success response' do
      sign_in admin1
      visit admin_all_users_path
      expect(page).to have_content('All Users')
      expect(edit_buttons.count).to be >= 1 # to verify that the admin account is able to see all users
      # click on a random edit button
      edit_buttons = all('a', text: 'Edit')
      edit_buttons.sample.click
      puts edit_buttons.count
      # puts "Current path: #{current_path}" # for debugging
      fill_in 'user_first_name', with: 'updatedFirstName'
      click_button 'Update User'
      expect(page).to have_content('All Users')
    end
  end

  # TODO

  describe 'PATCH #approve_user' do
    it 'returns a success response' do
      sign_in admin1
      visit admin_all_users_path
      expect(page).to have_content('All Users')
      td = page.find.all('td', text: 'Pending')
      tr = td.sample.find(:xpath, './parent::tr')
      pending_users = all('tr', text: 'Pending')
      pending_users.sample.click_button('Edit')

      edit_buttons.sample.click
      expect(page).to have_content('Edit User')

      click_button 'Approve User'
      expect(page).to have_content('Active')
    end
  end
end
