require 'test_helper'

class ParkingTest < ActiveSupport::TestCase
  def setup
    @parking = parkings(:renoma)
  end

  test 'parking should be valid' do
    assert @parking.valid?
  end

  test 'when parking has no places parameter' do
    @parking.places = nil
    assert_not @parking.valid?
    assert @parking.errors.has_key?(:places)
  end

  test 'when parking has no hour_price parameter' do
    @parking.hour_price = nil
    assert_not @parking.valid?
    assert @parking.errors.has_key?(:hour_price)
  end

  test 'when parking has no day_price parameter' do
    @parking.day_price = nil
    assert_not @parking.valid?
    assert @parking.errors.has_key?(:day_price)
  end

  test 'when parking has no kind parameter' do
    @parking.kind = nil
    assert_not @parking.valid?
    assert @parking.errors.has_key?(:kind)
  end

  test 'when hour_price is not valid' do
    @parking.hour_price = '10.123123'
    assert_not @parking.valid?
    assert @parking.errors.has_key?(:hour_price)
  end

  test 'when day_price is not valid' do
    @parking.day_price = '10.123123'
    assert_not @parking.valid?
    assert @parking.errors.has_key?(:day_price)
  end

  test 'when kind is not valid' do
    @parking.kind = 'public'
    assert_not @parking.valid?
    assert @parking.errors.has_key?(:kind)
  end
end
