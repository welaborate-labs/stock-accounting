require 'rails_helper'

RSpec.describe "statements/edit", type: :view do
  before(:each) do
    @statement = assign(:statement, Statement.create!(
      statement_file: nil
    ))
  end

  it "renders the edit statement form" do
    render

    assert_select "form[action=?][method=?]", statement_path(@statement), "post" do

      assert_select "input[name=?]", "statement[statement_file_id]"
    end
  end
end
