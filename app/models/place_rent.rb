class PlaceRent < ActiveRecord::Base
  before_save :calculate_price

  belongs_to :car
  belongs_to :parking

  validates :start_date, :end_date, :parking, :car, presence: true

  def calculate_price
    day_price = parking.day_price
    hour_price = parking.hour_price
    day_spent = (end_date - start_date).to_i / 1.day
    hours_spent = (end_date - start_date).to_i / 1.hour
    self.price = (day_price * day_spent) + (hour_price * hours_spent)
  end
end
