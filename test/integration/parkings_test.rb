require 'test_helper'

class ParkingsTest < ActionDispatch::IntegrationTest
  def setup
    @parking = parkings(:renoma)
  end

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
    assert has_content? 'Listing parkings'
  end

  test 'user opens parking details' do
    visit '/parkings'
    click_link 'Show'
    assert has_content? 'Places: 600'
    assert has_content? 'Kind: private'
    assert has_content? 'Hour price: 3.0'
    assert has_content? 'Day price: 25.0'
    assert has_content? 'City: 50-950 Wroclaw'
    assert has_content? 'Street: Swidnicka'
    assert has_content? 'Owner: Steve Jobs'
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
    assert_not has_content? 'Wroclaw'
    assert_not has_content? '600'
    assert_not has_content? '3.0'
    assert_not has_content? '25.0'
  end

  test 'user rents a place rent on a parking' do
    visit '/parkings'
    click_link 'Rent a place'
    select '2015', from: 'place_rent_start_date_1i'
    select 'January', from: 'place_rent_start_date_2i'
    select '1', from: 'place_rent_start_date_3i'
    select '10', from: 'place_rent_start_date_4i'
    select '20', from: 'place_rent_start_date_5i'
    select '2015', from: 'place_rent_end_date_1i'
    select 'January', from: 'place_rent_end_date_2i'
    select '5', from: 'place_rent_end_date_3i'
    select '10', from: 'place_rent_end_date_4i'
    select '20', from: 'place_rent_end_date_5i'
    select 'BMW 535i', from: 'place_rent_car_id'
    click_button 'Create Place rent'
    assert has_content? 'The place rent has been created!'
    assert has_content? 'Start date: 01.01.2015, 10:20'
    assert has_content? 'End date: 05.01.2015, 10:20'
    assert has_content? 'Car: BMW 535i'
  end
end
