require 'rails_helper'

RSpec.describe "statements/new", type: :view do
  before(:each) do
    assign(:statement, Statement.new(
      statement_file: nil
    ))
  end

  it "renders new statement form" do
    render

    assert_select "form[action=?][method=?]", statements_path, "post" do

      assert_select "input[name=?]", "statement[statement_file_id]"
    end
  end
end
