class Car < ActiveRecord::Base
  belongs_to :owner, class_name: 'Person'
  has_many :place_rents

  validates :registration_number, :model, :owner, presence: true

  def to_param
    "#{id}-#{model.parameterize}"
  end
end
