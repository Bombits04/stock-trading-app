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

  it 'is invalid without a first name' do
    user.first_name = nil
    expect(user).not_to be_valid
  end

  it 'is invalid without a last name' do
    user.last_name = nil
    expect(user).not_to be_valid
  end

  it 'is invalid with a duplicate email' do
    user_with_duplicate_email = user.dup
    user_with_duplicate_email.email = user.email
    user_with_duplicate_email.save
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
end
