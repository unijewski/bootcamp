class SessionsController < ApplicationController
  def create
    person_id = Account.find_by(email: params[:session][:email]).try(:person_id)
    person = Person.find_by(id: person_id)
    account = Account.authenticate(params[:session][:email], params[:session][:password])

    sign_in(person, account)
  end

  def destroy
    session.delete(:id)
    redirect_to root_path, notice: 'You are logged out!'
  end

  private

  def sign_in(person, account)
    if person && account
      session[:id] = person.id
      redirect_to root_path, notice: 'Welcome!'
    else
      flash.now[:alert] = 'Invalid email or password!'
      render 'new'
    end
  end
end
