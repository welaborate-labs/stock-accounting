class Account < ApplicationRecord
  # belongs to
  belongs_to :user

  # has_many
  has_many :statement_files,      dependent: :destroy
  has_many :brokerage_accounts,   dependent: :destroy

  # presence
  validates :name,                presence: :true
  validates :document,            presence: :true
  validates :address,             presence: :true
  validates :city,                presence: :true
  validates :state,               presence: :true
  validates :country,             presence: :true
  validates :zipcode,             presence: :true
  validates :status,              presence: :true

  # format
  validates :phone_personal,
            :phone_business,
            :phone_mobile,        format: { with: /([0-9]{2})([0-9]{3,4}[0-9]{4,5})/ }, 
                                  allow_blank: true
  validates :document,            format: { with: /([0-9]{2}[\.]?[0-9]{3}[\.]?[0-9]{3}[\/]?[0-9]{4}[-]?[0-9]{2})|([0-9]{3}[\.]?[0-9]{3}[\.]?[0-9]{3}[-]?[0-9]{2})/ }
  validates :zipcode,             format: { with: /([0-9]{5}[\-]?[0-9]{3})/ }

  # length
  validates :name,                length: { minimum: 3, maximum: 150 }
  validates :document,            length: { minimum: 11, maximum: 18 }
  validates :address,             length: { minimum: 30, maximum: 300 }
  validates :city,                length: { minimum: 4, maximum: 50 }
  validates :state,               length: { minimum: 2, maximum: 20 }
  validates :country,             length: { minimum: 4, maximum: 40 }
  validates :zipcode,             length: { minimum: 8, maximum: 9 }
  validates :phone_personal,
            :phone_business,
            :phone_mobile,        length: { minimum: 8, maximum: 15 }, 
                                  allow_blank: true
end
