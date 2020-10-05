require 'rails_helper'

RSpec.describe BrokerageAccount, type: :model do
  let(:brokerage_account) { build(:brokerage_account) }
  let(:statement_file) { create(:statement_file, :with_file) } 
  let(:invalid) { build(:brokerage_account, account: nil, brokerage: nil, number: nil) }

  describe "valid attributes" do
    subject { create(:brokerage_account) }
    it { is_expected.to be_valid }
  end

  describe "invalid attributes" do
    before { invalid.save }
    subject { invalid.errors.full_messages } 

    it { is_expected.to include("Account must exist", 
                                "Account can't be blank",
                                "Brokerage can't be blank",
                                "Number can't be blank") }
  end
  
  describe "relationships" do
    context "has many/dependent destroy" do
      context "statements" do       
        before { FactoryBot.create_list(:statement, 3, brokerage_account: brokerage_account, statement_file: statement_file) }
        it { expect(brokerage_account.statements.count).to eq(3) }
        it { expect{brokerage_account.destroy}.to change{Statement.count}.by(-3) }
      end      
    end
  end
end
