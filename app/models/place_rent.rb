class PlaceRent < ActiveRecord::Base
  belongs_to :cars
  belongs_to :parking
end
