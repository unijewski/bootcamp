class Car < ActiveRecord::Base
  belongs_to :owner, class_name: 'Person'
  has_many :place_rents

  validates :registration_number, :model, :owner, presence: true

  def slug
    model.downcase.gsub(' ', '-')
  end

  def to_param
    "#{id}-#{slug}"
  end
end
