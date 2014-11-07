require 'test_helper'

class ParkingsTest < ActionDispatch::IntegrationTest
  test 'user opens parkings index' do
    visit '/parkings'
    assert has_content? 'parkings'
  end

  test 'user opens parking details' do
    visit '/parkings'
    click_link 'Show'
    assert has_content? 'Places'
    assert has_content? 'Kind'
    assert has_content? 'Hour price'
    assert has_content? 'Day price'
  end

  test 'user add a new parking' do
    visit '/parkings'
    click_link 'New parking'
    fill_in 'Places', with: '100'
    select 'private', from: 'Kind'
    fill_in 'Hour price', with: '3.50'
    fill_in 'Day price', with: '25.00'
    fill_in 'City', with: 'City'
    fill_in 'Street', with: 'Street'
    fill_in 'Zip code', with: '12-345'
    click_button 'Create Parking'
    assert has_content? 'Parking details'
    assert has_content? 'Places: 100'
    assert has_content? 'Kind: private'
    assert has_content? 'Hour price: 3.5'
    assert has_content? 'Day price: 25.0'
    assert has_content? 'City: 12-345 City'
    assert has_content? 'Street: Street'
  end
end
