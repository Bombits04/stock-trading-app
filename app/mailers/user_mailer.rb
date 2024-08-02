class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.user_email.subject
  #
  def email_user(user)
    @user = user
    @greeting = 'Hi'

    mail(to: @user.email, subject: 'Your account has been approved')
  end
end
