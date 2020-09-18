require 'rails_helper'

RSpec.describe StatementFile, type: :model do
  let(:statement_file) { create(:statement_file, :with_attachment) }

  it 'is valid with valid attributes' do
    expect(statement_file).to be_valid
  end
  
  it "is not valid without a attach file" do
    statement_file.attach_file = nil
    
    expect(statement_file).not_to be_valid
    expect(statement_file.errors.keys).to include :attach_file
    expect(statement_file.errors[:attach_file]).to include "can't be blank"
  end
end
