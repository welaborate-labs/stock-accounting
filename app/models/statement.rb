class Statement < ApplicationRecord
  belongs_to :statement_file
  belongs_to :brokerage_account
  has_many :trades, dependent: :destroy
end
