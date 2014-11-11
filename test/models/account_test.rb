require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  def setup
    @account = accounts(:steve_account)
  end

  test 'account should be valid' do
    assert @account.valid?
  end

  test 'when account has no valid email' do
    @account.email = 'mail@mail,+com.'
    assert_not @account.valid?
    assert @account.errors.has_key?(:email)
  end

  test 'when we execute authenticate method with valid parameters' do
    account = Account.authenticate(@account.email, 'secret123')
    assert_equal @account, account
  end

  test 'when we execute authenticate method with invalid parameters' do
    account = Account.authenticate(@account.email, 'secret')
    assert_equal false, account
  end
end
