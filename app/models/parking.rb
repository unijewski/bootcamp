class Parking < ActiveRecord::Base
  KIND_TYPES = %w(outdoor indoor private street)

  belongs_to :address
  belongs_to :owner, class_name: 'Person'
  has_many :place_rents

  validates :places, presence: true
  validates :hour_price, presence: true,
                         numericality: true
  validates :day_price, presence: true,
                         numericality: true
  validates :kind, inclusion: { in: KIND_TYPES }
end
