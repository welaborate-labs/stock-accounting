require 'rails_helper'

RSpec.describe "statement_files/index", type: :view do
  let!(:statement_file) { create(:statement_file, :with_attachment) } 

  it "renders a list of statement_files"
end
