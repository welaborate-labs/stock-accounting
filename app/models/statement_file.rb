class StatementFile < ApplicationRecord
  has_one_attached :attach_file
  validates_presence_of :attach_file
end
