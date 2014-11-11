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
    assert has_content? 'Listing parking'
  end
end
