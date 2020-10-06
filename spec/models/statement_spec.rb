require 'rails_helper'
require 'sidekiq/testing' 

RSpec.describe Statement, type: :model do
  let(:statement_file) { build(:statement_file, :with_attachment) } 

  describe 'validations' do
    context 'valid' do
      subject { build(:statement, statement_file: statement_file) }

      it { is_expected.to be_valid }
    end

    context 'invalid' do
      subject { build(:statement) }

      it { is_expected.not_to be_valid }
      it { expect(statement.errors.keys).to include :statement_file }
      it { expect(statement.errors[:statement_file]).to include 'must exist' }
    end
  end
end
