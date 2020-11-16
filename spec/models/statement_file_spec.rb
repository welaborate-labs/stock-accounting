require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe StatementFile, type: :model do
  let(:account) { create(:account) }
  let!(:statement_file) { create(:statement_file, :with_file, account: account) }
  let!(:statement_file_invalid) { build(:statement_file, account: nil, file: nil) }

  describe 'valid file' do
    it { is_expected.to validate_content_type_of(:file).allowing('application/pdf') }
    it { is_expected.to validate_size_of(:file).less_than(5.megabytes) }
  end
    
  describe "valid attributes" do
    subject { build(:statement_file, :with_file) }
  
    it { is_expected.to be_valid }
  end

  describe "invalid attributes" do
    before { statement_file_invalid.save }

    it { is_expected.to be_invalid }

    context "file" do
      it { expect(statement_file_invalid.errors[:file]).to include("can't be blank") }
    end
    
    context "account" do
      it { expect(statement_file_invalid.errors[:account]).to include("must exist", "can't be blank") }
    end
  end

  describe "relationships" do
    context "statements" do
      before do
        FactoryBot.create_list(:statement, 3, statement_file: statement_file)
      end

      describe "has many" do
        it { expect(statement_file.statements.count).to eq(3) }
      end

      describe "dependent destroy" do
        it { expect{statement_file.destroy}.to change{Statement.count}.by(-3) }
      end
    end
  end
end