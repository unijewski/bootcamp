require 'test_helper'

class CarTest < ActiveSupport::TestCase
  def setup
    @car = cars(:bmw)
  end

  test 'car should be valid' do
    assert @car.valid?
  end

  test 'when car has no registration_number parameter' do
    @car.registration_number = nil
    assert_not @car.valid?
    assert @car.errors.has_key?(:registration_number)
  end

  test 'when car has no model parameter' do
    @car.model = nil
    assert_not @car.valid?
    assert @car.errors.has_key?(:model)
  end

  test 'when car has no owner parameter' do
    @car.owner = nil
    assert_not @car.valid?
    assert @car.errors.has_key?(:owner_id)
  end
end
