class FacebookAccount < ActiveRecord::Base
  has_one :person

  validates :uid, :person, presence: true
end
