require 'rails_helper'
require 'sidekiq/testing' 

RSpec.describe Statement, type: :model do
  let(:user) { create(:user) } 
  let(:account) { create(:account, user: user) }
  let(:brokerage_account) { create(:brokerage_account, account: account) } 
  let(:statement_file) { build(:statement_file, :with_file, account: account) }
  let(:statement) { build(:statement, statement_file: statement_file ) } 
  let(:invalid) { build(:statement, statement_file: nil, brokerage_account: nil) } 
  before { allow_any_instance_of(ApplicationController).to receive(:current_user) { user } }

  describe 'valid attributes' do
    subject { statement }
    before do
      allow(statement).to receive(:statement_file) { statement_file }
    end
    
    it { is_expected.to be_valid }
  end

  describe 'invalid attributes' do
    before { invalid.save }
    subject { invalid.errors.full_messages }

    it { is_expected.to eq(["Statement file must exist", "Brokerage account must exist"]) }
  end

  describe "relationships" do
    context "has many/dependent destroy" do
     before { FactoryBot.create_list(:trade, 3, statement: statement) } 
     it { expect(statement.trades.count).to eq(3) }
     it { expect{statement.destroy}.to change{Trade.count}.by(-3) }
    end
  end
end
