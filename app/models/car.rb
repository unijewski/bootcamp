class Car < ActiveRecord::Base
  belongs_to :owner, class_name: 'Person'

  validates :registration_number, presence: true
  validates :model, presence: true
  validates :owner_id, presence: true
end
