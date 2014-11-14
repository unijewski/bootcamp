require 'test_helper'

class FacebookAccountsTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.reset!
    OmniAuth.config.test_mode = true
  end

  def mock_auth
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      provider: 'facebook',
      uid: '123545',
      info: {
        first_name: 'Steve',
        last_name: 'Jobs'
      }
    })
  end

  test 'user signs in by facebook with proper data' do
    visit '/'
    mock_auth
    click_link 'Sign in with Facebook'
    assert has_content? 'Welcome Steve Jobs'
  end

  test 'user signs in but there is an error' do
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    visit '/'
    click_link 'Sign in with Facebook'
    assert has_content? 'Error!'
    assert_equal '/en', current_path
  end
end
