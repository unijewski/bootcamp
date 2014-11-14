class AccountMailer < ActionMailer::Base
  default from: 'hello@bookparking.dev'

  def welcome_email(account)
    @account = account
    @url = login_url(:en)
    mail(to: @account.email, subject: 'Welcome to Bookparking')
  end
end
