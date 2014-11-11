class SessionsController < ApplicationController
  def create
    account = Account.authenticate(params[:session][:email], params[:session][:password])

    sign_in(account)
  end

  def destroy
    session.delete(:id)
    redirect_to root_path, notice: 'You are logged out!'
  end

  private

  def sign_in(account)
    if account
      session[:id] = account.person.id
      redirect_back_or root_path
      flash[:notice] = 'Welcome!'
    else
      flash.now[:alert] = 'Invalid email or password!'
      render 'new'
    end
  end
end
