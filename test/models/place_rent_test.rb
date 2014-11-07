require 'test_helper'

class PlaceRentTest < ActiveSupport::TestCase
  def setup
    @place_rent = place_rents(:bmw_at_renoma)
  end

  test 'place_rent should be valid' do
    assert @place_rent.valid?
  end

  test 'when place_rent has no start_date parameter' do
    @place_rent.start_date = nil
    assert_not @place_rent.valid?
    assert @place_rent.errors.has_key?(:start_date)
  end

  test 'when place_rent has no end_date parameter' do
    @place_rent.end_date = nil
    assert_not @place_rent.valid?
    assert @place_rent.errors.has_key?(:end_date)
  end

  test 'when place_rent has no parking parameter' do
    @place_rent.parking = nil
    assert_not @place_rent.valid?
    assert @place_rent.errors.has_key?(:parking_id)
  end

  test 'when place_rent has no car parameter' do
    @place_rent.car = nil
    assert_not @place_rent.valid?
    assert @place_rent.errors.has_key?(:car_id)
  end
end
