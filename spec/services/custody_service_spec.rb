require 'rails_helper'

RSpec.describe Custody do
  let(:account) { create(:account) } 
  let(:brokerage_account) { create(:brokerage_account, account: account) }
  let(:statement) { create(:statement , brokerage_account: brokerage_account) }
  let(:statement2) { create(:statement , brokerage_account: brokerage_account) }
  let!(:trade) { create(:trade, statement: statement) }
  let!(:trade2) { create(:trade, statement: statement) }
  let!(:trade3) { create(:trade, statement: statement, close: true) }
  let!(:trade4) { create(:trade, statement: statement2) }
  let!(:trade5) { create(:trade, statement: statement2, close: true) }
  
  describe "returns the custody trades" do
    before { allow_any_instance_of(ApplicationController).to receive(:choosen_account) { account } }
    subject { Custody.trades_custody }
    context "should return the open trades" do
      it { expect(subject).to include trade, trade2, trade4 }
      
    end
    context "should not return the close trades" do
      it { expect(subject).not_to include trade3, trade5 }
      
    end
  end

  describe "returns the avg price" do
    it { expect(Custody.avg_cust).to eq [[[trade], [30.0]], 
                                         [[trade2], [30.0]], 
                                         [[trade4], [30.0]]] }
  end
end
