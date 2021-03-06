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
    parking = parkings(:renoma2)
    parkings = Parking.public_parkings.order(:id)
    assert_equal [parking], parkings
  end

  test 'when we query about private parkings' do
    parkings = Parking.private_parkings
    assert_equal [@parking], parkings
  end

  test 'when we query about parkings by day price' do
    parking2 = parkings(:renoma2)
    parkings = Parking.by_day_price(20, 50).order(:id)
    assert_equal [parking2, @parking], parkings
  end

  test 'when we query about parkings by hour price' do
    parking2 = parkings(:renoma2)
    parkings = Parking.by_hour_price(1, 10)
    assert_equal [parking2, @parking], parkings
  end

  test 'when we query about parkings by city' do
    parkings = Parking.by_city('Wroclaw')
    assert_equal [@parking], parkings
  end
end
