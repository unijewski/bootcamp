require 'test_helper'

class SessionsTest < ActionDispatch::IntegrationTest
  test 'user logs in' do
    visit '/session/new'
    fill_in 'E-mail', with: 'steve@jobs.com'
    click_button 'New Session'
    assert has_content? 'Welcome, Steve Jobs'
  end

  test 'user is not logged in' do
    assert_not has_content? 'Welcome, Steve Jobs'
  end
end
