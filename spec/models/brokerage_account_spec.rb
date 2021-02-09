require 'rails_helper'

RSpec.describe BrokerageAccount, type: :model do
  let!(:user) { create(:user) }
  let!(:account) { create(:account, user: user) }
  let!(:brokerage_account) { create(:brokerage_account, account: account) }
  let(:statement_file) { create(:statement_file, :with_file, account: account) } 
  let(:invalid) { build(:brokerage_account, account: nil, brokerage: nil, number: nil) }

  describe "valid attributes" do
    subject { create(:brokerage_account, account: account) }
    it { is_expected.to be_valid }
  end

  describe "invalid attributes" do
    before { invalid.save }
    subject { invalid.errors.full_messages } 

    it { is_expected.to eq(["Account é obrigatório(a)", "Account não pode ficar em branco", "Corretora não pode ficar em branco", "Número não pode ficar em branco"]) }
  end
  
  describe "relationships" do
    context "has many/dependent destroy" do
      context "statements" do
        before { create(:statement, statement_file: statement_file, brokerage_account: brokerage_account) }
        it { expect(brokerage_account.statements.count).to eq(1) }
        it { expect{brokerage_account.destroy}.to change{Statement.count}.by(-1) }
      end
    end
  end
end
