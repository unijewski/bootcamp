class PlaceRent < ActiveRecord::Base
  before_save :calculate_price

  belongs_to :car
  belongs_to :parking

  validates :start_date, :end_date, :parking, :car, presence: true

  def calculate_price
    self.price = (day_price * day_spent) + (hour_price * hours_spent)
  end

  private

  def day_price
    parking.day_price
  end

  def hour_price
    parking.hour_price
  end

  def day_spent
    (end_date - start_date).to_i / 1.day
  end

  def hours_spent
    (end_date - start_date).to_i / 1.hour
  end
end
