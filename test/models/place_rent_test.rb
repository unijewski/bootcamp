require 'test_helper'
require 'pry'

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
    assert @place_rent.errors.has_key?(:parking)
  end

  test 'when place_rent has no car parameter' do
    @place_rent.car = nil
    assert_not @place_rent.valid?
    assert @place_rent.errors.has_key?(:car)
  end

  test 'when we want to calculate a price for 3 days' do
    @place_rent.save
    assert_equal BigDecimal(291), @place_rent.price
  end

  test 'when we want to calculate a price for 3 days and 1 hour' do
    @place_rent2 = place_rents(:bmw2_at_renoma)
    @place_rent2.save
    assert_equal BigDecimal(294), @place_rent2.price
  end

  test 'when we want to calculate a price for 3 hours' do
    @place_rent3 = place_rents(:bmw3_at_renoma)
    @place_rent3.save
    assert_equal BigDecimal(9), @place_rent3.price
  end
end
