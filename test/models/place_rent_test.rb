require 'test_helper'

class PlaceRentTest < ActiveSupport::TestCase
  test 'should save place rent with all parameters' do
    place_rent = place_rents(:bmw_at_renoma)
    assert place_rent.save
  end

  test 'should not save place rent with no parameters' do
    place_rent = PlaceRent.new
    assert_not place_rent.save
  end

  test 'should not save when only one of parameters is given' do
    place_rent = PlaceRent.new(start_date: Time.now)
    assert_not place_rent.save
  end
end
