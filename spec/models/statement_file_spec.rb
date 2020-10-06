require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe StatementFile, type: :model do
  describe 'validations' do
    subject { build(:statement_file, :with_file) }

    it { is_expected.to validate_content_type_of(:file).allowing('application/pdf') }
    it { is_expected.to validate_size_of(:file).less_than(5.megabytes) }

    context 'valid' do
      subject { build(:statement_file, :with_file) }

      it { is_expected.to be_valid }
    end
    
    context 'without file' do
      subject { build(:statement_file) }

      it { is_expected.not_to be_valid }
    end
  end
end
