class BrokerageAccount < ApplicationRecord
  belongs_to :account
  has_many :statements, dependent: :destroy
  has_many :trades, through: :statements
  validates_presence_of :account, :brokerage, :number
end
