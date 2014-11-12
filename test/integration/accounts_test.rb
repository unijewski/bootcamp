require 'test_helper'

class AccountsTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.reset!
  end

  def assert_rendered_form_with_errors
    assert_equal '/accounts', current_path
    assert has_content? 'Oooups! Something went wrong'
    assert has_content? 'New account'
  end

  test 'user signs up without a first name' do
    visit '/accounts/new'
    fill_in 'Email', with: 'foo@bar.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Create Account'
    assert_rendered_form_with_errors
    assert has_content? 'Person first name can\'t be blank'
  end

  test 'user signs up without an email' do
    visit '/accounts/new'
    fill_in 'First name', with: 'Steve'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Create Account'
    assert_rendered_form_with_errors
    assert has_content? 'Email can\'t be blank'
    assert has_content? 'Email is invalid'
  end

  test 'user signs up without passwords' do
    visit '/accounts/new'
    fill_in 'First name', with: 'Steve'
    fill_in 'Email', with: 'foo@bar.com'
    click_button 'Create Account'
    assert_rendered_form_with_errors
    assert has_content? 'Password can\'t be blank'
  end

  test 'user fills in different passwords' do
    visit '/accounts/new'
    fill_in 'First name', with: 'Steve'
    fill_in 'Email', with: 'foo@bar.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'drowssap'
    click_button 'Create Account'
    assert_rendered_form_with_errors
    assert has_content? 'Password confirmation doesn\'t match Password'
  end

  test 'user signs up with proper data' do
    visit '/accounts/new'
    fill_in 'First name', with: 'Steve'
    fill_in 'Last name', with: 'Works'
    fill_in 'Email', with: 'foo@bar.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Create Account'
    assert has_content? 'Welcome'
    assert has_content? 'Parkings'
    assert_equal '/', current_path
  end
end
