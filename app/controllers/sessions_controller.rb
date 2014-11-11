class SessionsController < ApplicationController
  def create
    account = Account.authenticate(params[:session][:email], params[:session][:password])

    sign_in(account)
  end

  def destroy
    session.delete(:id)
    redirect_to root_path, notice: 'You are logged out!'
  end
end
