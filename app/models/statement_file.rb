class StatementFile < ApplicationRecord
  has_one_attached :attach_file
  validates_presence_of :attach_file
  has_many :statements, dependent: :destroy
  validates :attach_file, attached: true, 
                          size: { less_than: 5.megabytes}, 
                          content_type: { in: 'application/pdf'}
end
