require 'test_helper'

class ApplicationHelperTest < ActiveSupport::TestCase
  include ApplicationHelper

  test 'should display controller name as page title' do
    assert_equal 'Place rents', page_title
  end

  private

  def params
    { controller: 'place_rents' }
  end
end
