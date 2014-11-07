class Address < ActiveRecord::Base
  ZIP_CODE_REGEX = /\A\d{2}-\d{3}\z/

  has_one :parking

  validates :city, :street, presence: true
  validates :zip_code, presence: true,
                       format: { with: ZIP_CODE_REGEX }
end
