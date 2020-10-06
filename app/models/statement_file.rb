class StatementFile < ApplicationRecord
  has_one_attached :file
  has_many :statements, dependent: :destroy

  validates :file, presence: true
  validates :file, attached: true,
    size: { less_than: 5.megabytes },
    content_type: { in: 'application/pdf' }
end
