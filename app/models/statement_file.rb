class StatementFile < ApplicationRecord
  has_one_attached :file
  has_many :statements, dependent: :destroy
  belongs_to :account
  after_create :parse_file

  validates :account, presence: true
  validates :file, presence: true
  validates :file, attached: true,
    size: { less_than: 20.megabytes },
    content_type: { in: 'application/pdf' }

  private
    def parse_file
      ProcessStatementFileJob.perform_later(statement_file_id: id)
    end
end
