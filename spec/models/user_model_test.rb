require 'rails_helper'

RSpec.describe User type: :model do
  describe "validations" do
    it "requires a first name" do
      user = User.new(first_name: "")
      user.valid?
      expect(user.errors).to have_key(:first_name)
    end

    it "requires a last name" do
      user = User.new(last_name: "")
      user.valid?
      expect(user.errors).to have_key(:last_name)
    end

    it "requires a user type" do
      user = User.new(user_type: "")
      user.valid?
      expect(user.errors).to have_key(:user_type)
    end

    it "requires a user type to be either 'admin' or 'trader'" do
      user = User.new(user_type: "invalid")
      user.valid?
      expect(user.errors).to have_key(:user_type)
    end

    it "requires an email" do
      user = User.new(email: "")
      user.valid?
      expect(user.errors).to have_key(:email)
    end

    it "requires a unique email" do
      user1 = User.create(email: "email@email.com")
      user2 = User.new(email: "email@email.com")
      user2.valid?
      expect(user2.errors).to have_key(:email)
    end

    it "requires a password" do
      user = User.new(password: "")
      user.valid?
      expect(user.errors).to have_key(:password)
    end

    it "requires a password to be at least 6 characters" do
      user = User.new(password: "12345")
      user.valid?
      expect(user.errors).to have_key(:password)
    end

    it "requires a password to be at most 16 characters" do
      user = User.new(password: "123123123123123123")
      user.valid?
      expect(user.errors).to have_key(:password)
    end
  end
end
