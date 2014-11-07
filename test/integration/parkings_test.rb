require 'test_helper'

class ParkingsTest < ActionDispatch::IntegrationTest
  test "user opens parkings index" do
    visit '/parkings'
    assert has_content? 'Parkings'
  end
end
