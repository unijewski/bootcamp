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

  test 'when we display full name' do
    assert_equal 'Steve Jobs', @person.full_name
  end

  test 'when we display full name if there is only a name' do
    @person.last_name = nil
    assert_equal 'Steve', @person.full_name
  end
end
