require 'test_helper'

class CarTest < ActiveSupport::TestCase
  test 'should save car with all parameters' do
    car = cars(:bmw)
    assert car.save
  end

  test 'should not save car with no parameters' do
    car = Car.new
    assert_not car.save
  end

  test 'should not save when one of parameters is not given' do
    car = Car.new(model: 'model', registration_number: 'number')
    assert_not car.save
  end
end
