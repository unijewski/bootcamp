class PlaceRent < ActiveRecord::Base
  belongs_to :car
  belongs_to :parking

  validates :start_date, :end_date, :parking, :car, presence: true
end
