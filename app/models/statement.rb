class Statement < ApplicationRecord
  belongs_to :statement_file, optional: true
  belongs_to :brokerage_account

  has_many :trades, dependent: :destroy

  before_validation :set_brokerage_account_from_content
  before_validation :set_statement_date_from_content
  after_create :generate_trades
  after_create :set_costs
  after_create :set_paid_taxes

  validates :number, uniqueness: { scope: :brokerage_account_id }
  validates :statement_date, presence: true
  validates :number, presence: true

  accepts_nested_attributes_for :trades, allow_destroy: true, reject_if: :all_blank

  private

    def set_statement_date_from_content
      if content && statement_file
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

    def parser
      @parser ||= StatementParser.new(content: content) if content
    end

    def generate_trades
      if content
        parser.trades.each do |trade|
          trades.create(trade)
        end
      end
    end

    def set_costs
      if content
        # TODO: Set the costs related to this statement from the parser data
      end
    end

    def set_paid_taxes
      if content
        # TODO: Set the paid taxes related to this statement from the parser data
      end
    end
end
