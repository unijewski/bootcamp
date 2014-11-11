require 'test_helper'

class SessionsTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.reset!
  end

  test 'user logs in' do
    visit '/session/new'
    fill_in 'session_email', with: 'steve@jobs.com'
    click_button 'Sign in'
    assert has_content? 'Welcome, Steve Jobs'
  end

  test 'user is not logged in' do
    visit '/'
    assert_not has_content? 'Welcome, Steve Jobs'
  end
end
