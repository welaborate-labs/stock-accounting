class Custody
  def self.trades_custody
    Rails.cache.fetch([@choosen_account,__method__], expires_in: 5.seconds) do
      statements = Statement.where(brokerage_account: BrokerageAccount.first)
      statements.map { |statement| statement.trades.where(close: 0) }      
    end
  end

  def self.avg_cust(trade)
    Rails.cache.fetch([trade.id,__method__], expires_in: 5.seconds) do
      (trade.quantity /  (trade.price.to_f * trade.quantity)).truncate(2)
    end
  end
end