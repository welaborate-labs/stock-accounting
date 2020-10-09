require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:user) { create(:user) }
  let!(:account) { create(:account, user: user) }
  let(:account_invalid) { build(:account, name: nil, document: nil, user: nil)  }

  describe "valid attributes" do
    subject { build(:account) }
    it { is_expected.to be_valid }
  end

  describe "invalid attributes" do
    before { account_invalid.save }

    it { is_expected.to be_invalid }

    context "name" do
      it { expect(account_invalid.errors[:name]).to include "can't be blank" }
    end

    context "document" do
      it { expect(account_invalid.errors[:document]).to include "can't be blank" }
    end

    context "user" do
      it { expect(account_invalid.errors[:user]).to include("must exist", "can't be blank") }
    end
  end

  describe "relationships" do
    before do
      FactoryBot.create_list(:statement_file, 3, :with_file, account: account)
    end

    context "statement_files" do
      context "has many" do
        it { expect(account.statement_files.count).to eq(3) }
      end

      context "dependent destroy" do
        it { expect{account.destroy}.to change{StatementFile.count}.by(-3) }
      end
    end
  end
  
end
