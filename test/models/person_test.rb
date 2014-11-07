require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  def setup
    @person = people(:steve)
  end

  test 'person should be valid' do
    assert @person.valid?
  end

  test 'when person has no first_name parameter' do
    @person.first_name = nil
    assert_not @person.valid?
    assert @person.errors.has_key?(:first_name)
  end

  test 'when person has no last_name parameter' do
    @person.last_name = nil
    assert_not @person.valid?
    assert @person.errors.has_key?(:last_name)
  end

  test 'when person has no parameters' do
    @person.first_name, @person.last_name = nil
    assert_not @person.valid?
    assert @person.errors.has_key?(:first_name)
    assert @person.errors.has_key?(:last_name)
  end
end
