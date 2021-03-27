class Trade < ApplicationRecord
  belongs_to :statement
  validates :ticker, presence: :true
  validates :direction, presence: :true
  validates :quantity, presence: :true
  validates :price, presence: :true
  enum status: [:open, :close]

  accepts_nested_attributes_for :statement, allow_destroy: true, reject_if: :all_blank
end