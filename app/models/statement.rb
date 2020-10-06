class Statement < ApplicationRecord
  belongs_to :statement_file
  has_many :transactions, dependent: :destroy
end
