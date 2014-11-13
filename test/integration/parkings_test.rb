require 'test_helper'

class ParkingsTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.reset!
    @parking = parkings(:renoma)
  end

  def sign_in
    visit '/en/login'
    fill_in 'session_email', with: 'steve@jobs.com'
    fill_in 'session_password', with: 'secret123'
    click_button 'Sign in'
  end

  def fill_in_the_form
    fill_in 'parking_places', with: '100'
    select 'Private', from: 'parking_kind'
    fill_in 'parking_hour_price', with: '3.50'
    fill_in 'parking_day_price', with: '25.00'
    fill_in 'parking_address_attributes_city', with: 'City'
    fill_in 'parking_address_attributes_street', with: 'Street'
    fill_in 'parking_address_attributes_zip_code', with: '12-345'
  end

  test 'user opens parkings index' do
    visit '/en/parkings'
    assert has_content? 'Parkings'
  end

  test 'user opens parking details' do
    visit '/en/parkings'
    find('tr', text: 'Wroclaw').click_link 'Show'
    assert has_content? 'Places 600'
    assert has_content? 'Kind private'
    assert has_content? 'Hour price 3.0'
    assert has_content? 'Day price 25.0'
    assert has_content? 'City 50-950 Wroclaw'
    assert has_content? 'Street Swidnicka'
    assert has_content? 'Owner Steve Jobs'
  end

  test 'user adds a new parking' do
    visit '/en/parkings'
    click_link 'New parking'
    fill_in_the_form
    click_button 'Execute'
    assert has_content? 'Parking details'
    assert has_content? 'Places 100'
    assert has_content? 'Kind private'
    assert has_content? 'Hour price 3.5'
    assert has_content? 'Day price 25.0'
    assert has_content? 'City 12-345 City'
    assert has_content? 'Street Street'
    assert has_content? 'The parking has been created!'
  end

  test 'user edits a parking' do
    visit '/en/parkings'
    find('tr', text: 'Wroclaw').click_link 'Edit'
    fill_in_the_form
    click_button 'Execute'
    assert has_content? 'Parking details'
    assert has_content? 'Places 100'
    assert has_content? 'Kind private'
    assert has_content? 'Hour price 3.5'
    assert has_content? 'Day price 25.0'
    assert has_content? 'City 12-345 City'
    assert has_content? 'Street Street'
    assert has_content? 'The parking has been updated!'
  end

  test 'user removes a parking' do
    visit '/en/parkings'
    find('tr', text: 'Wroclaw').click_link 'Remove'
    assert has_content? 'The parking has been deleted!'
    assert_not has_content? 'Wroclaw'
    assert_not has_content? '600'
    assert_not has_content? '3.0'
    assert_not has_content? '25.0'
  end

  test 'user rents a place rent on a parking' do
    sign_in
    visit '/en/parkings'
    find('tr', text: 'Wroclaw').click_link 'Rent a place'
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

  test 'user fills in whole search form' do
    visit '/en/parkings'
    check 'kind_private'
    fill_in 'day_price_start_range', with: '15.00'
    fill_in 'day_price_end_range', with: '25.00'
    fill_in 'hour_price_start_range', with: '3.00'
    fill_in 'hour_price_end_range', with: '5.00'
    fill_in 'city', with: 'Wroclaw'
    click_button 'Search'
    assert find_field('kind_private').checked?
    assert_equal '15.00', find_field('day_price_start_range').value
    assert_equal '25.00', find_field('day_price_end_range').value
    assert_equal '3.00', find_field('hour_price_start_range').value
    assert_equal '5.00', find_field('hour_price_end_range').value
    assert_equal 'Wroclaw', find_field('city').value
    assert_not has_content? 'Krakow'
    assert_not has_content? '6.00'
    assert_not has_content? '30.00'
  end

  test 'user rents a place rent on a parking but is not logged in' do
    visit '/en/parkings'
    find('tr', text: 'Wroclaw').click_link 'Rent a place'
    assert has_content? 'You are not logged in!'
    assert_not has_content? 'New place rent'
  end
end
