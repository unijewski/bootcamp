class FacebookAccount < ActiveRecord::Base
  belongs_to :person

  validates :uid, :person, presence: true

  def self.find_or_create_for_facebook(auth_hash)
    where(uid: auth_hash[:uid]).first_or_create do |account|
      account.uid = auth_hash[:uid]
      account.build_person(
        first_name: auth_hash[:info][:first_name],
        last_name: auth_hash[:info][:last_name]
      )
      account.save
    end
  end
end
