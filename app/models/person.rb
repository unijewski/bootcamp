class Person < ActiveRecord::Base
  has_many :cars, foreign_key: 'owner_id'
  has_many :parkings, foreign_key: 'owner_id'
  has_one :account

  validates :first_name, presence: true

  def full_name
    if last_name.present?
      first_name + ' ' + last_name
    else
      first_name
    end
  end
end
