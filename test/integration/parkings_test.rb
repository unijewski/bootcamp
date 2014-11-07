require 'test_helper'

class ParkingsTest < ActionDispatch::IntegrationTest
  test 'user opens parkings index' do
    visit '/parkings'
    assert has_content? 'parkings'
  end

  test 'user opens parking details' do
    visit 'parkings'
    click_link('Show')
    assert has_content? 'Places'
    assert has_content? 'Kind'
    assert has_content? 'Hour price'
    assert has_content? 'Day price'
  end
end
