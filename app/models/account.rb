class Account < ApplicationRecord
  # belongs to
  belongs_to :user

  # has_many
  has_many :statement_files,      dependent: :destroy
  has_many :brokerage_accounts,   dependent: :destroy

  # presence
  validates :name,                presence: :true
  validates :document,            presence: :true

  # format
  validates :phone_personal,
            :phone_business,
            :phone_mobile,        format: { with: /\(?[0-9]{2}\)?[\s]?[0-9]{3,5}[\s-]?[0-9]{4}/ }, allow_blank: true
  validates :document,            format: { with: /([0-9]{2}[\.]?[0-9]{3}[\.]?[0-9]{3}[\/]?[0-9]{4}[-]?[0-9]{2})|([0-9]{3}[\.]?[0-9]{3}[\.]?[0-9]{3}[-]?[0-9]{2})/ }
  validates :zipcode,             format: { with: /([0-9]{5}[\-]?[0-9]{3})/ }, allow_blank: true

  # length
  validates :name,                length: { minimum: 3, maximum: 150 }
  validates :document,            length: { minimum: 11, maximum: 18 }
  validates :phone_personal,
            :phone_business,
            :phone_mobile,        length: { minimum: 8, maximum: 15 }, 
                                  allow_blank: true
end
