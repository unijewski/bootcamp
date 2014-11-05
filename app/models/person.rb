class Person < ActiveRecord::Base
  has_many :cars
  has_many :parkings

  validates :first_name, presence: true
end
