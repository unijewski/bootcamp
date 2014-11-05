require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test 'should save person with all parameters' do
    person = people(:steve)
    assert person.save
  end

  test 'should not save person with first_name parameter' do
    person = Person.new(last_name: 'last_name')
    assert_not person.save
  end

  test 'should save when only first_name is given' do
    person = Person.new(first_name: 'first_name')
    assert person.save
  end
end
