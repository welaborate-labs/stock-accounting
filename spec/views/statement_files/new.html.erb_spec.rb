require 'rails_helper'

RSpec.describe "statement_files/new", type: :view do
  before(:each) do
    assign(:statement_file, StatementFile.new())
  end

  it "renders new statement_file form" do
    render

    assert_select "form[action=?][method=?]", statement_files_path, "post" do
    end
  end
end
