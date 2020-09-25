require 'rails_helper'
require 'sidekiq/testing' 

RSpec.describe Statement, type: :model do
  let!(:statement_file) { create(:statement_file, :with_attachment) } 
  let(:statement) { build(:statement) }

  describe "valid attributes" do
    subject { create(:statement, statement_file_id: statement_file.id) }

    it { is_expected.to be_valid }
  end
 
  describe "invalid attributes (statement_file must exist)" do
      before do
        statement.save
      end
      
      it { is_expected.not_to be_valid }
      it { expect(statement.errors.keys).to include :statement_file }
      it { expect(statement.errors[:statement_file]).to include "must exist" }
  end
end
