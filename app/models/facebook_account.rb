class FacebookAccount < ActiveRecord::Base
  belongs_to :person

  validates :uid, :person, presence: true

  def self.find_or_create_for_facebook(auth_hash)
    find_by(uid: auth_hash[:uid]) || FacebookAccount.create_facebook_account(auth_hash)
  end

  private

  def self.create_facebook_account(auth_hash)
    fb_account = FacebookAccount.new(uid: auth_hash[:uid])
    fb_account.build_person
    fb_account.person.first_name = auth_hash[:info][:first_name]
    fb_account.person.last_name = auth_hash[:info][:last_name]
    fb_account.save
    fb_account
  end
end
