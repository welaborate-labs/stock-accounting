require 'rails_helper'
require 'sidekiq/testing' 

RSpec.describe Statement, type: :model do
  let(:statement_file) { build(:statement_file, :with_file) }
  let(:statement) { build(:statement, statement_file: statement_file) } 
  let(:invalid) { build(:statement, statement_file: nil, brokerage_account: nil) } 

  describe 'valid attributes' do
    subject { create(:statement, statement_file: statement_file) }
    it { is_expected.to be_valid }
  end

  describe 'invalid attributes' do
    before { invalid.save }
    subject { invalid.errors.full_messages }

    it { is_expected.to include("Statement file must exist",
                                "Brokerage account must exist") }
  end

  describe "relationships" do
    context "has many/dependent destroy" do
     before { FactoryBot.create_list(:trade, 3, statement: statement) } 
     it { expect(statement.trades.count).to eq(3) }
     it { expect{statement.destroy}.to change{Trade.count}.by(-3) }
    end
  end
end
