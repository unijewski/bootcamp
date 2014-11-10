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

  test 'when parking is deleted' do
    place_rent = @parking.place_rents.first
    @parking.destroy
    assert_equal Time.now.utc.to_s, place_rent.reload.end_date.to_s
  end

  test 'when we query about public parkings' do
    parkings = Parking.public_parkings
    assert_equal 1, parkings.size
    assert_equal 300, parkings.first.places
    assert_equal 6.00, parkings.first.hour_price
    assert_equal 30.00, parkings.first.day_price
    assert_equal 'public', parkings.first.kind
  end

  test 'when we query about private parkings' do
    parkings = Parking.private_parkings
    assert_equal 1, parkings.size
    assert_equal 600, parkings.first.places
    assert_equal 3.00, parkings.first.hour_price
    assert_equal 25.00, parkings.first.day_price
    assert_equal 'private', parkings.first.kind
  end

  test 'when we query about parkings by day price' do
    parkings = Parking.by_day_price(20, 50)
    assert_equal 2, parkings.size
    assert_equal [300, 600], parkings.map(&:places)
    assert_equal ['public', 'private'], parkings.map(&:kind)
  end

  test 'when we query about parkings by hour price' do
    parkings = Parking.by_hour_price(1, 10)
    assert_equal 2, parkings.size
    assert_equal [300, 600], parkings.map(&:places)
    assert_equal ['public', 'private'], parkings.map(&:kind)
  end

  test 'when we query about parkings by city' do
    parkings = Parking.by_city('Wroclaw')
    assert_equal 1, parkings.size
    assert_equal 600, parkings.first.places
    assert_equal 3.00, parkings.first.hour_price
    assert_equal 25.00, parkings.first.day_price
    assert_equal 'private', parkings.first.kind
  end
end
