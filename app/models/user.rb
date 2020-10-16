class User  < ApplicationRecord
  has_many :authentications
  has_many :accounts, dependent: :destroy
  
  validates_presence_of :name, :email
  validates_uniqueness_of :email

  def self.create_from_hash(auth)
    user = create! do |user|
      user.name = auth['info']['name']
      user.email = auth['info']['email']
    end
    user
  end
end
