class BrokerageAccount < ApplicationRecord
  belongs_to :account
  has_many :statements, dependent: :destroy
  validates_presence_of :account, :brokerage, :number
end
