require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  def setup
    @address = addresses(:wroclaw)
  end

  test 'address should be valid' do
    assert @address.valid?
  end

  test 'when address has no city parameter' do
    @address.city = nil
    assert_not @address.valid?
    assert @address.errors.has_key?(:city)
  end

  test 'when address has no street parameter' do
    @address.street = nil
    assert_not @address.valid?
    assert @address.errors.has_key?(:street)
  end

  test 'when address has no zip_code parameter' do
    @address.zip_code = nil
    assert_not @address.valid?
    assert @address.errors.has_key?(:zip_code)
  end

  test 'should not save when zip code is not valid' do
    @address.zip_code = '123456'
    assert_not @address.valid?
    assert @address.errors.has_key?(:zip_code)
  end
end
