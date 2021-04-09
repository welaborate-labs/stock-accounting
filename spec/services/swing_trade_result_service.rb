require 'rails_helper'

RSpec.describe SwingTradeResult do
  let(:brokerage_account) { create(:brokerage_account) }
  let(:statement) { create(:statement,
    brokerage_account_id: brokerage_account.id,
    statement_date: '07/04/2021') }
  let(:statement2) { create(:statement,
    brokerage_account_id: brokerage_account.id,
    statement_date: '09/04/2021') }

  50.times do |i|
    let!("#{:trade}#{i}") { 
      create(:trade, statement_id: statement.id,
      price: 0.25,
      quantity: 10,
      direction: 0)}
  end
  
  50.times do |i|
    let!("#{:trade_}#{i}") { 
      create(:trade, statement_id: statement.id,
      price: 0.25,
      quantity: 10,
      direction: 1)}
  end

  let(:trade) { create(:trade,
    statement_id: statement2.id,
    price: 5,
    quantity: 10,
    direction: 1) }

  let(:swing_trade) { SwingTradeResult.new(
    brokerage_account: brokerage_account,
    ticker: trade.ticker,
    date: statement2.statement_date,
    direction: trade.direction,
    qty: trade.quantity,
    price: trade.price) }

  context "when swing trade exists" do
    describe "returns a closed trade" do
      before do 
        trade1.quantity = 11
        trade1.save
      end
      it { expect(swing_trade.is_trade_closed).to eq true } 
      it { expect(swing_trade.result).to eq 4.75 } 
    end

    describe "when got profit" do
      before do
        trade1.price = 1
        trade1.save
      end

      it { expect(swing_trade.is_profit).to eq true } 
      it { expect(swing_trade.profit_value).to eq 7.5 } 
    end

    describe "when do not got profit" do
      before do
        trade_2.price = 2
        trade_2.save
      end

      it { expect(swing_trade.is_profit).to eq false } 
      it { expect(swing_trade.profit_value).to eq -17.5 } 
    end

    describe "returns negative custodies" do
      before do
        trade_2.quantity = 200
        trade_2.save
      end

      it { expect(swing_trade.is_trade_closed).to eq false }
    end
  end

  context "when swing trade does not exist" do
    describe "returns 0 for not found" do
      before { Trade.where(direction: 0).destroy_all }

      it { expect(swing_trade.is_trade_closed).to eq false } 
      it { expect(swing_trade.result).to eq 0 } 
    end
  end
end
