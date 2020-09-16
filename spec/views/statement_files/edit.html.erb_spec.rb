require 'rails_helper'

RSpec.describe "statement_files/edit", type: :view do
  before(:each) do
    @statement_file = assign(:statement_file, StatementFile.create!())
  end

  it "renders the edit statement_file form" do
    render

    assert_select "form[action=?][method=?]", statement_file_path(@statement_file), "post" do
    end
  end
end
