require 'rails_helper'

RSpec.describe "statement_files/show", type: :view do
  before(:each) do
    @statement_file = assign(:statement_file, StatementFile.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
