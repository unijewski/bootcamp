require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  test 'should save address with all parameters' do
    address = addresses(:wroclaw)
    assert address.save
  end

  test 'should not save address with no parameters' do
    address = Address.new
    assert_not address.save
  end

  test 'should not save when one of parameters is not given' do
    address = Address.new(city: 'city', street: 'street')
    assert_not address.save
  end

  test 'should not save when zip code is not valid' do
    address = Address.new(city: 'city', street: 'street', zip_code: '123456')
    assert_not address.save
  end
end
