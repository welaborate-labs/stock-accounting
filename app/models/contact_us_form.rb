class ContactUsForm
  include ActiveModel::Validations

  attr_accessor :email, :message

  validates :email, presence: true
  validates :message, presence: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :message, length: { minimum: 1, maximum: 1000 }
end
