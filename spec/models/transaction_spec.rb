require 'rails_helper'
require 'sidekiq/testing' 

RSpec.describe Transaction, type: :model do
  let!(:statement_file) { create(:statement_file, :with_attachment) } 
  let!(:statement) { create(:statement, statement_file_id: statement_file.id) }
  let(:transaction) { build(:transaction) }

  describe "valid attributes" do
    subject { create(:transaction, statement_id: statement.id) }

    it { is_expected.to be_valid }
  end
 
  describe "invalid attributes (statement must exist)" do
      before do
        transaction.save
      end
      
      it { is_expected.not_to be_valid }
      it { expect(transaction.errors.keys).to include :statement }
      it { expect(transaction.errors[:statement]).to include "must exist" }
  end
end
