require 'test_helper'

class CarsTest < ActionDispatch::IntegrationTest
  test 'user opens cars index' do
    visit '/cars'
    assert has_content? 'Listing cars'
  end

  test 'user opens car details' do
    visit '/cars'
    click_link 'Show'
    assert has_content? 'Registration number'
    assert has_content? 'Model'
  end
end
