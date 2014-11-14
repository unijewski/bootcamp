require 'test_helper'

class FacebookAccountsTest < ActionDispatch::IntegrationTest
  setup { mock_auth }

  test 'user signs in by facebook with proper data' do
    visit '/'
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
