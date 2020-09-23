class Authentication < ApplicationRecord
  belongs_to :user
  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, scope: :provider

  def self.find_or_create_from_hash(hash)
    authorization = find_by(provider: hash['provider'], uid: hash['uid'])

    if authorization
      return authorization
    end

    user = User.find_by(email: hash['info']['email'])
    if !user
      user ||= User.create_from_hash(hash)
    end

    Authentication.create!(user: user, uid: hash['uid'], provider: hash['provider']) 
  end
end
