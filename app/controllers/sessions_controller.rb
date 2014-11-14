class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']

    if auth_hash && auth_hash.include?(:uid)
      facebook = FacebookAccount.find_or_create_for_facebook(auth_hash)
      sign_in(facebook)
    else
      account = Account.authenticate(params[:session][:email], params[:session][:password])
      sign_in(account)
    end
  end

  def destroy
    session.delete(:id)
    redirect_to root_path, notice: 'You are logged out!'
  end

  def failure
    redirect_to root_path, alert: 'Error!'
  end
end
