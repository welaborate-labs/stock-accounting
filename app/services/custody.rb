class Custody
  def self.trades_custody
    Rails.cache.fetch([@choosen_account,__method__], expires_in: 5.seconds) do
      statements = Statement.where(brokerage_account: BrokerageAccount.first)
      statements.map { |statement| statement.trades.where(status: 0) }.flatten
    end
  end

  def self.avg_cust
    Rails.cache.fetch([@choosen_account,__method__], expires_in: 5.seconds) do
      result = []
      trades_custody.each_with_index do |v, i|
        result[i] = [v],[check_avg_cust(v)]
      end
      result.uniq
    end
  end

  def self.check_avg_cust(trade)
    value = trade.price.to_f * trade.quantity / trade.quantity 
    trades_custody.each do |t|
      if t.ticker == trade.ticker && t.id != trade.id && t.direction == trade.direction
        value += t.price.to_f * t.quantity / t.quantity
      else
        next
      end
    end
    value
  end
end