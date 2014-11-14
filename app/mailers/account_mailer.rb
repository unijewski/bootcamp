class AccountMailer < ActionMailer::Base
  default from: 'hello@bookparking.dev'

  def welcome_email(account)
    @account = account
    @url = 'http://localhost:3000/en/login'
    mail(to: @account.email, subject: 'Welcome to Bookparking')
  end
end
