class Statement < ApplicationRecord
  belongs_to :statement_file
  belongs_to :brokerage_account
  has_many :trades, dependent: :destroy
  before_validation :set_brokerage_account_from_content
  before_validation :set_statement_date_from_content
  validates :number, uniqueness: { scope: :brokerage_account_id }

  private

    def set_statement_date_from_content
      if content
        self.statement_date = content.match('\d{1,2}\/\d{1,2}\/\d{4}').to_s
      end
    end

    def set_brokerage_account_from_content
      if content && statement_file
        client_number = content.match('\d{7}\-?\d{1}').to_s
        account = statement_file.account
        self.brokerage_account = account.brokerage_accounts.find_or_create_by(brokerage: 1, number: client_number)
      end
    end
end
