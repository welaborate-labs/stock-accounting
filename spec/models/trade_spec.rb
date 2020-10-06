require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe Trade, type: :model do
  let(:statement_file) { build(:statement_file, :with_attachment) } 
  let(:statement) { build(:statement, statement_file: statement_file) }

  describe 'validatons' do
    context 'valid' do
      subject { build(:trade, statement: statement) }

      it { is_expected.to be_valid }
    end

    context 'invalid' do
      subject { build(:trade) }

      it { is_expected.not_to be_valid }
      it { expect(trade.errors.keys).to include :statement }
      it { expect(trade.errors[:statement]).to include 'must exist' }
    end
  end
end
