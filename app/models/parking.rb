class Parking < ActiveRecord::Base
  PRICE_REGEX = /\A\d+(?:\.\d{0,2})?\z/
  KIND_TYPES = %w(outdoor indoor private street)

  before_destroy :finish_rental

  belongs_to :address
  accepts_nested_attributes_for :address
  belongs_to :owner, class_name: 'Person'
  has_many :place_rents

  validates :places, presence: true
  validates :hour_price, presence: true,
                         format: { with: PRICE_REGEX,
                                   numericality: { greater_than: 0 }
                         }
  validates :day_price, presence: true,
                        format: { with: PRICE_REGEX,
                                   numericality: { greater_than: 0 }
                        }
  validates :kind, inclusion: { in: KIND_TYPES }

  scope :public_parkings, -> { where(kind: 'public') }
  scope :private_parkings, -> { where(kind: 'private') }
  scope :parkings_by_day_price, ->(from_price, to_price) { where('day_price BETWEEN ? AND ?', from_price, to_price)  }
  scope :parkings_by_hour_price, ->(from_price, to_price) { where('hour_price BETWEEN ? AND ?', from_price, to_price)  }
  scope :parkings_by_city, ->(city) { joins(:address).where('city = ?', city) }

  private

  def finish_rental
    self.place_rents.each { |place_rent| place_rent.update(end_date: Time.now) }
  end
end
