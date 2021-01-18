require 'rails_helper'
require 'sidekiq/testing' 

RSpec.describe Statement, type: :model do
  let(:user) { create(:user) } 
  let(:account) { create(:account, user: user) }
  let(:brokerage_account) { create(:brokerage_account, account: account) } 
  let(:statement_file) { build(:statement_file, :with_file, account: account) }
  let(:statement) { build(:statement) }
  let(:invalid) { build(:statement, statement_file: nil, brokerage_account: nil, number: nil, statement_date: nil) } 
  before { allow_any_instance_of(ApplicationController).to receive(:current_user) { user } }

  describe 'valid attributes' do
    subject { statement }
    
    context "with statement file" do
      before { statement.statement_file = statement_file }
      it { is_expected.to be_valid }
    end

    context "without statement file" do
      it { is_expected.to be_valid }
    end
  end

  describe 'invalid attributes' do
    before { invalid.save }
    subject { invalid.errors.full_messages }

    it { is_expected.to eq(["Brokerage account must exist", "Statement date can't be blank", "Number can't be blank"]) }
  end

  describe "relationships" do
    context "has many/dependent destroy" do
     before { FactoryBot.create_list(:trade, 3, statement: statement) } 
     it { expect(statement.trades.count).to eq(3) }
     it { expect{statement.destroy}.to change{Trade.count}.by(-3) }
    end
  end
end
