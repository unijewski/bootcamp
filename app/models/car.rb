class Car < ActiveRecord::Base
  belongs_to :owner, class_name: 'Person'
  has_many :place_rents

  validates :registration_number, :model, :owner, presence: true
  validates_size_of :image, maximum: 600.kilobytes, message: :big_image

  dragonfly_accessor :image

  def to_param
    "#{id}-#{model.parameterize}"
  end
end
