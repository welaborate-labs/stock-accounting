require 'rails_helper'

RSpec.describe "statements/index", type: :view do
  before(:each) do
    assign(:statements, [
      Statement.create!(
        statement_file: nil
      ),
      Statement.create!(
        statement_file: nil
      )
    ])
  end

  it "renders a list of statements" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
