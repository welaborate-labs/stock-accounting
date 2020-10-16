class StatementFile < ApplicationRecord
  has_one_attached :file
  has_many :statements, dependent: :destroy
  belongs_to :account

  validates :account, presence: true
  validates :file, presence: true
  validates :file, attached: true,
    size: { less_than: 5.megabytes },
    content_type: { in: 'application/pdf' }
end
