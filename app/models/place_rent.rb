class PlaceRent < ActiveRecord::Base
  belongs_to :car
  belongs_to :parking

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :parking_id, presence: true
  validates :car_id, presence: true
end
