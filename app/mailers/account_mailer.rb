class AccountMailer < ActionMailer::Base
  default from: 'hello@bookparking.dev'

  def welcome_email(account)
    @account = account
    @url = login_path(:en)
    mail(to: @account.email, subject: 'Welcome to Bookparking')
  end
end
