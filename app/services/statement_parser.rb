class StatementParser
  attr_reader :content

  def initialize(content:)
    @content = content
  end

  def trades
    @trades ||= trades_rows.map do |trade_row|
      trade_row_data = trade_row.split(/\s+/)
      expiration = trade_row_data[2] == 'VISTA' ? null : trade_row_data.delete_at(3)

      {
        ticker: trade_row_data[6],
        direction: trade_row_data[1] == 'C' ? 0 : 1,
        quantity: trade_row_data[5].sub(",", ""),
        price: trade_row_data[6].sub(",", "."),
        is_debit: trade_row_data[7] == 'D',
        expiration: expiration
      }
    end
  end

  def trades_rows
    @trades_rows ||= content.match(/[CV]\s.*[DC]\n/)
  end

  def costs
    @costs ||= costs_row.match(/\d+,\d\d/) if costs_row.present?
  end

  def paid_tax
    @paid_tax ||= paid_tax_row.match(/\d+,\d\d/) if paid_tax_row.present?
  end

  def costs_row
    @costs_row ||= content.match(/Total corretagem \/ Despesas\s+\d+,\d\d\s+[DC]\n/)
  end

  def paid_tax_row
    @paid_tax_row ||= content.match(/I\.R\.R\.F\.\s+\d+,\d\d\s+[DC]\n/)
  end
end
