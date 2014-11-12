class PlaceRent < ActiveRecord::Base
  before_save :calculate_price

  belongs_to :car
  belongs_to :parking

  validates :start_date, :end_date, :parking, :car, presence: true
  validates :identifier, uniqueness: true

  scope :unfinished, -> { where('end_date > ?', Time.now) }

  def calculate_price
    self.price = (day_price * days_spent) + (hour_price * hours_spent)
  end

  def finish
    update(end_date: Time.now)
  end

  def to_param
    identifier
  end

  def self.find_by_param(input)
    find_by_identifier(input)
  end

  private

  def day_price
    parking.day_price
  end

  def hour_price
    parking.hour_price
  end

  def days_spent
    (end_date - start_date).to_i / 1.day
  end

  def hours_spent
    (end_date - start_date).to_i / 1.hour
  end
end
