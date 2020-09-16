require 'rails_helper'

RSpec.describe "statement_files/index", type: :view do
  before(:each) do
    assign(:statement_files, [
      StatementFile.create!(),
      StatementFile.create!()
    ])
  end

  it "renders a list of statement_files" do
    render
  end
end
