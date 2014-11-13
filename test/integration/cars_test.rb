require 'test_helper'

class CarsTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.reset!
    @car = cars(:bmw)
  end

  def sign_in
    visit '/session/new'
    fill_in 'session_email', with: 'steve@jobs.com'
    fill_in 'session_password', with: 'secret123'
    click_button 'Sign in'
  end

  def fill_in_the_form
    fill_in 'Registration number', with: 'KR 1234A'
    fill_in 'Model', with: 'BMW'
    attach_file('Image', File.join(Rails.root, '/test/fixtures/test_ok.png'))
  end

  test 'user opens cars index' do
    sign_in
    visit '/en/cars'
    assert has_content? 'Listing cars'
    assert has_content? 'DW 12345'
    assert has_content? 'BMW 535i'
  end

  test 'user opens car details' do
    sign_in
    visit '/en/cars'
    click_link 'Show'
    assert has_content? 'Registration number: DW 12345'
    assert has_content? 'Model: BMW 535i'
    assert true, @car.image.present?
  end

  test 'user adds a new car' do
    sign_in
    visit '/en/cars'
    click_link 'New car'
    fill_in_the_form
    click_button 'Create Car'
    assert has_content? 'Registration number: KR 1234A'
    assert has_content? 'Model: BMW'
    assert has_content? 'The car has been created!'
    assert true, @car.image.present?
  end

  test 'user adds a new car with too big image' do
    sign_in
    visit '/en/cars'
    click_link 'New car'
    fill_in 'Registration number', with: 'KR 1234A'
    fill_in 'Model', with: 'BMW'
    attach_file('Image', File.join(Rails.root, '/test/fixtures/test_fail.jpg'))
    click_button 'Create Car'
    assert has_content? 'Oooups! Something went wrong'
    assert has_content? 'Image should be smaller than 600 KBs'
  end

  test 'user edits a car' do
    sign_in
    visit '/en/cars'
    click_link 'Edit'
    fill_in_the_form
    click_button 'Update Car'
    assert has_content? 'Registration number: KR 1234A'
    assert has_content? 'Model: BMW'
    assert has_content? 'The car has been updated!'
    assert true, @car.image.present?
  end

  test 'user removes a car' do
    sign_in
    visit '/en/cars'
    click_link 'Remove'
    assert has_content? 'The car has been deleted!'
    assert_not has_content? 'DW 12345'
    assert_not has_content? 'BMW 535i'
  end

  test 'user opens car index but is not logged in' do
    visit '/en/cars'
    assert has_content? 'You are not logged in!'
    assert_not has_content? 'Listing cars'
  end
end
