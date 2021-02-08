require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:user) { create(:user) }
  let!(:account) { create(:account, user: user) }
  let(:account_invalid) { build(:account, user: nil,
                                          name: nil,
                                          document: nil) }

  describe "valid attributes" do
    subject { create(:account) }
    it { is_expected.to be_valid }
  end

  describe "invalid attributes" do
    before { account_invalid.save }
    subject { account_invalid.errors.full_messages }

    it { is_expected.to eq(["Usuário é obrigatório(a)", 
                            "Nome não pode ficar em branco", 
                            "Nome é muito curto (mínimo: 3 caracteres)", 
                            "Documento não pode ficar em branco",
                            "Documento não é válido", 
                            "Documento é muito curto (mínimo: 11 caracteres)"]) }
  end

  describe "relationships" do
    context "has many/dependent destroy" do
      context "statement_files" do
        before { FactoryBot.create_list(:statement_file, 3, :with_file, account: account) }
        it { expect(account.statement_files.count).to eq(3) }
        it { expect{account.destroy}.to change{StatementFile.count}.by(-3) }
      end

      context "brokerage_accounts" do
        before { FactoryBot.create_list(:brokerage_account, 3, account: account) } 
        it { expect(account.brokerage_accounts.count).to eq(3) }
        it { expect{account.destroy}.to change{BrokerageAccount.count}.by(-3) }
      end
    end
  end
end
