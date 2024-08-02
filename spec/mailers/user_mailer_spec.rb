require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  fixtures :users
  let(:trader) { users(:trader) }
  describe 'user_email' do
    let(:mail) { UserMailer.email_user(trader) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Your account has been approved')
      expect(mail.from).to eq(['niggatron01@wigga.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to have_content("We are happy to tell you that you're account has been approved and you now have access to trade!")
    end
  end
end
