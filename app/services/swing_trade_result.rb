class SwingTradeResult
  attr_reader :brokerage_account, :ticker, :date, :position, :qty, :price

  def initialize(brokerage_account:, ticker:, date:, direction:, qty:, price:)
    @brokerage_account = brokerage_account
    @ticker = ticker
    @date = date
    @position = position
    @qty = qty
    @price = price
  end

  def is_trade_closed
    custody_quantity > 0
  end

  def result
    qty * price_delta
  end

  private

  def previous_trades
    @previous_trades ||= brokerage_account.trades
      .joins(:statements)
      .where('statements.statement_date < ?', date)
      .where(ticker: ticker)
      .order('statements.statement_date ASC')
  end

  def previous_opposite_trades
    @previous_opposite_trades ||= previous_trades.where.not(direction: direction)
  end

  def previous_same_trades
    @previous_same_trades ||= previous_trades.where(direction: direction)
  end

  def custody_quantity
    @previous_position ||= previous_opposite_trades.sum(:quantity) - previous_same_trades.sum(:quantity)
  end

  def average_custody_price
    @average_custody_price ||= previous_opposite_trades.sum('quantity * price').to_f / previous_opposite_trades.sum(:quantity).to_f
  end

  def price_delta
    @price_delta ||= price - average_custody_price
  end
end