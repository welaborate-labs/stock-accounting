class Account < ApplicationRecord
  belongs_to :user
  has_many :statement_files, dependent: :destroy
  has_many :brokerage_accounts, dependent: :destroy
  validates :name, presence: :true
  validates :document, presence: :true
  validates :user, presence: :true
end
