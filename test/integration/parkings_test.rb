require 'test_helper'

class ParkingsTest < ActionDispatch::IntegrationTest
  def fill_in_the_form
    fill_in 'Places', with: '100'
    select 'private', from: 'Kind'
    fill_in 'Hour price', with: '3.50'
    fill_in 'Day price', with: '25.00'
    fill_in 'City', with: 'City'
    fill_in 'Street', with: 'Street'
    fill_in 'Zip code', with: '12-345'
  end

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

  test 'user adds a new parking' do
    visit '/parkings'
    click_link 'New parking'
    fill_in_the_form
    click_button 'Create Parking'
    assert has_content? 'Parking details'
    assert has_content? 'Places: 100'
    assert has_content? 'Kind: private'
    assert has_content? 'Hour price: 3.5'
    assert has_content? 'Day price: 25.0'
    assert has_content? 'City: 12-345 City'
    assert has_content? 'Street: Street'
    assert has_content? 'The parking has been created!'
  end

  test 'user edits a parking' do
    visit '/parkings'
    click_link 'Edit'
    fill_in_the_form
    click_button 'Update Parking'
    assert has_content? 'Parking details'
    assert has_content? 'Places: 100'
    assert has_content? 'Kind: private'
    assert has_content? 'Hour price: 3.5'
    assert has_content? 'Day price: 25.0'
    assert has_content? 'City: 12-345 City'
    assert has_content? 'Street: Street'
    assert has_content? 'The parking has been updated!'
  end

  test 'user removes a parking' do
    visit '/parkings'
    click_link 'Remove'
    assert has_content? 'The parking has been deleted!'
  end
end
