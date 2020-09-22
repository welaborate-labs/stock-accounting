class Authentication < ApplicationRecord
  belongs_to :user
  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, scope: :provider

  def self.find_from_hash(hash)
    find_by_provider_and_uid(hash['provider'], hash['uid'])
  end

  def self.create_from_hash(hash, user = nil)
    user = User.find_by(email: hash["info"]["email"])
    if !user
      user ||= User.create_from_hash(hash)
    end
    Authentication.create!(user: user, uid: hash['uid'], provider: hash['provider']) 
  end
end
