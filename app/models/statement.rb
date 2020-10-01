class Statement < ApplicationRecord
  belongs_to :statement_file
  has_many :trades, dependent: :destroy
end
