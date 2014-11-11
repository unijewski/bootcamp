require 'pry'
class SessionsController < ApplicationController
  def new
  end

  def create
    account = Account.find_by(email: params[:session][:email])
    person = Person.find_by(id: account.person_id)

    if person
      log_in(person)
      redirect_to parkings_path, notice: 'Welcome!'
    else
      redirect_to new_session_path, alert: 'Person not found!'
    end
  end

  private

  def log_in(person)
    session[:id] = person.id
  end
end
