require 'rails_helper'

RSpec.describe User, type: :model do
  fixtures :users

  let(:user) { users(:one) }

  it 'has a valid fixture' do
    expect(user).to be_valid
  end

  it 'is invalid without an email' do
    user.email = nil
    expect(user).not_to be_valid
  end

  # it 'is invalid without a first name' do
  #   user.first_name = nil
  #   expect(user).not_to be_valid
  # end

  # it 'is invalid without a last name' do
  #   user.last_name = nil
  #   expect(user).not_to be_valid
  # end

  it 'is invalid with a duplicate email' do
    user = User.create(
      first_name: 'John',
      last_name: 'Doe',
      email: 'john.doe@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
    user_with_duplicate_email = User.new(
      first_name: 'Jane',
      last_name: 'Smith',
      email: 'john.doe@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    )
    expect(user_with_duplicate_email).not_to be_valid
  end

  it 'is invalid with an improperly formatted email' do
    user.email = "invalid_email"
    expect(user).not_to be_valid
  end

  it 'is invalid without a password' do
    user.encrypted_password = nil
    expect(user).not_to be_valid
  end

  it 'is invalid with a short password' do
    user.password = "short"
    expect(user).not_to be_valid
  end

  it 'is valid with a proper email format' do
    user.email = "valid@example.com"
    user.password = "securepassword"
    expect(user).to be_valid
  end

  it 'is valid with a proper password length' do
    user.password = "securepassword"
    expect(user).to be_valid
  end

  it 'sets user_type to "trader" if blank before validation' do
    new_user = User.new(
      first_name: 'New',
      last_name: 'User',
      email: 'new.user@example.com',
      password: 'securepassword',
      password_confirmation: 'securepassword'
    )
    expect(new_user.user_type).to be_nil
    new_user.valid?
    expect(new_user.user_type).to eq('trader')
  end
end
