class Parking < ActiveRecord::Base
  belongs_to :address
  belongs_to :person
  has_many :place_rents
end
