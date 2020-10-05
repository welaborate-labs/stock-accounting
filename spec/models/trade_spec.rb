require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe Trade, type: :model do
  let(:statement_file) { build(:statement_file, :with_file) } 
  let(:statement) { build(:statement, statement_file: statement_file) }
  let(:invalid) { build(:trade, statement: nil) } 

  describe 'validatons' do
    context 'valid' do
      subject { build(:trade, statement: statement) }

      it { is_expected.to be_valid }
    end

    context 'invalid' do
      before { invalid.save }
      subject { invalid.errors.full_messages }

      it { expect(invalid.errors.keys).to include :statement }
      it { expect(invalid.errors[:statement]).to include 'must exist' }
    end
  end
end
