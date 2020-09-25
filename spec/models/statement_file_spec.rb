require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe StatementFile, type: :model do
  let(:statement_file) { create(:statement_file, :with_attachment) }

  describe "validations" do
    it { expect(statement_file).to be_valid }
    it { is_expected.to validate_content_type_of(:attach_file).allowing('application/pdf') }
    it { is_expected.to validate_size_of(:attach_file).less_than(5.megabytes) }
  end
  
  describe "invalid validations" do
    before do
      statement_file.attach_file = nil
      statement_file.save
    end
        
    it { expect(statement_file).not_to be_valid }
    it { expect(statement_file.errors.keys).to include :attach_file }
    it { expect(statement_file.errors[:attach_file]).to include "can't be blank" }
  end
end
