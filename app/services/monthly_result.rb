class MonthlyResult
  attr_reader :month

  def initialize(account, month) do
    @account = account
    @month = month
  end

  def month_begin
    month.beginning_of_month
  end

  def month_end
    month.end_of_month
  end

  def statements
    @statements ||= account.statements.where(statement_date: [month_begin..month_end])
  end

  def trades
    @trades ||= account.trades.where(id: statements.ids)
  end

  def fees_and_taxes
    @fees_and_taxes ||= statements.map { |s| s.fees_and_taxes }
  end

  def closed_positions
    # TODO
  end
end