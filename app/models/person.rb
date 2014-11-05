class Person < ActiveRecord::Base
  has_many :cars
  has_many :parkings
end
