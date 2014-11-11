require 'test_helper'

class SessionsTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.reset!
  end

  def sign_in
    visit '/session/new'
    fill_in 'session_email', with: 'steve@jobs.com'
    fill_in 'session_password', with: 'secret123'
    click_button 'Sign in'
  end

  test 'user logs in' do
    sign_in
    assert has_content? 'Welcome, Steve Jobs'
  end

  test 'user is not logged in' do
    visit '/'
    assert_not has_content? 'Welcome, Steve Jobs'
  end

  test 'user logs out' do
    sign_in
    visit '/'
    click_link 'Sign out'
    assert has_content? 'You are logged out!'
    assert has_content? 'Listing parkings'
  end

  test 'user logs in with invalid email' do
    visit '/session/new'
    fill_in 'session_email', with: 'steve@steve.com'
    fill_in 'session_password', with: 'secret123'
    click_button 'Sign in'
    assert has_content? 'Invalid email or password!'
    assert has_content? 'New session'
  end

  test 'user logs in with invalid password' do
    visit '/session/new'
    fill_in 'session_email', with: 'steve@jobs.com'
    fill_in 'session_password', with: 'secret'
    click_button 'Sign in'
    assert has_content? 'Invalid email or password!'
    assert has_content? 'New session'
  end

  test 'users logs in directly from the form' do
    sign_in
    assert has_content? 'Listing parkings'
  end

  test 'users logs in from another location' do
    visit '/cars'
    fill_in 'session_email', with: 'steve@jobs.com'
    fill_in 'session_password', with: 'secret123'
    click_button 'Sign in'
    assert current_path == '/cars'
  end
end
