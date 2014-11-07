require 'test_helper'

class CarsTest < ActionDispatch::IntegrationTest
  def setup
    @car = cars(:bmw)
  end

  def fill_in_the_form
    fill_in 'Registration number', with: 'KR 1234A'
    fill_in 'Model', with: 'BMW'
  end

  test 'user opens cars index' do
    visit '/cars'
    assert has_content? 'Listing cars'
    assert has_content? 'DW 12345'
    assert has_content? 'BMW 535i'
  end

  test 'user opens car details' do
    visit '/cars'
    click_link 'Show'
    assert has_content? 'Registration number: DW 12345'
    assert has_content? 'Model: BMW 535i'
  end

  test 'user adds a new car' do
    visit '/cars'
    click_link 'New car'
    fill_in_the_form
    click_button 'Create Car'
    assert has_content? 'Registration number: KR 1234A'
    assert has_content? 'Model: BMW'
    assert has_content? 'The car has been created!'
  end

  test 'user edits a car' do
    visit '/cars'
    click_link 'Edit'
    fill_in_the_form
    click_button 'Update Car'
    assert has_content? 'Registration number: KR 1234A'
    assert has_content? 'Model: BMW'
    assert has_content? 'The car has been updated!'
  end

  test 'user removes a car' do
    visit '/cars'
    click_link 'Remove'
    assert has_content? 'The car has been deleted!'
    assert_not has_content? 'DW 12345'
    assert_not has_content? 'BMW 535i'
  end
end
