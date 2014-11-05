require 'test_helper'

class ParkingTest < ActiveSupport::TestCase
  test 'should save parking with all parameters' do
    parking = parkings(:renoma)
    assert parking.save
  end

  test 'should not save parking with no parameters' do
    parking = Parking.new
    assert_not parking.save
  end

  test 'should not save when only one of parameters is given' do
    parking = Parking.new(places: 1000)
    assert_not parking.save
  end

  test 'should not save when kind field is not included in kind types' do
    parking = Parking.new(
      places: 1000,
      kind: 'kind',
      hour_price: 5.00,
      day_price: 50.00,
      address_id: 1,
      owner_id: 1
    )
    assert_not parking.save
  end

  test 'should not save when hour price field is not valid' do
    parking = Parking.new(
      places: 1000,
      kind: 'private',
      hour_price: 5.12345,
      day_price: 50.00,
      address_id: 1,
      owner_id: 1
    )
    assert_not parking.save
  end

  test 'should not save when day price field is not valid' do
    parking = Parking.new(
      places: 1000,
      kind: 'private',
      hour_price: 5.00,
      day_price: 5.12345,
      address_id: 1,
      owner_id: 1
    )
    assert_not parking.save
  end
end
