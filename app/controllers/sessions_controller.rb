class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']

    if auth_hash && auth_hash.include?(:uid)
      sign_in_with_facebook(auth_hash)
    else
      sign_in_by_default
    end
  end

  def destroy
    session.delete(:id)
    redirect_to root_path, notice: 'You are logged out!'
  end

  def failure
    redirect_to root_path, alert: 'Error!'
  end

  private

  def sign_in_by_default
    account = Account.authenticate(params[:session][:email], params[:session][:password])
    sign_in(account)
  end

  def sign_in_with_facebook(auth_hash)
    facebook = FacebookAccount.find_or_create_for_facebook(auth_hash)
    sign_in(facebook)
  end
end
