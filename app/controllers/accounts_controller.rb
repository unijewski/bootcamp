class AccountsController < ApplicationController
  def new
    if current_person
      redirect_back_or root_path
    else
      @account = Account.new
      @account.build_person
    end
  end

  def create
    @account = Account.new(accounts_params)

    if @account.save
      sign_in @account
    else
      flash[:alert] = 'Oooups! Something went wrong'
      render 'new'
    end
  end

  private

  def accounts_params
    params.require(:account).permit(:email, :password, :password_confirmation, person_attributes:[:first_name, :last_name])
  end
end
